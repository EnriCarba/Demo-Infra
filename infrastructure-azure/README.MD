# Azure Infrastructure
To enhance the management and maintainability of the Terraform code, the modules are organized in a dedicated folder for each one. This enables the `main.tf` file to efficiently reuse the module code for provisioning the infrastructure.

## **Prerequisites**
- Install Azure CLI using the [Microsoft documentation](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
- In order to provision an AKS cluster, we need to have a **Service Principal**. In this way we can Authenticate with Azure an provision the resource. We will see how to create one right after this section.
- Run `az aks install-cli` so we can work with the Kubernetes Cluster from our terminal, also you can use it directly from the Azure Portal Terminal. 

---
## Steps
1- Create a Service Principal
- Use `az login` to log into your azure account, after that the following information will be shown on the terminal. Make sure to take note of the "id" value.
  
  ![az-login-info](/infra-doc/az-login.png)

- With that value, make sure to edit the following command in order to create the Service Principal: 

      az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX" --name "ServicePrincipalName"

  Take note on the "appId" and "password" values:

  ![app-id](/infra-doc/app-id.png)

- Now let's create an Azure Key Vault so you can save your credentials on the cloud to keep them safe, if you don't have it already go on and create a Resource
  Group as well to keep them appart from everything.
      
      az group create --location eastus --name MyResourceGroup

      az keyvault create --location eastus --name KeyVaultDemoAzureInfra --resource-group MyResourceGroup

- Store the values in an Azure Key Vault so we can authenticate automatically when we are provisioning the AKS cluster. The spId is the app id we got before, the spSecret is the password.

      az keyvault secret set --vault-name "KeyVaultDemoAzureInfra" --name "spId" --value "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"

      az keyvault secret set --vault-name "KeyVaultDemoAzureInfra" --name "spSecret" --value "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

- To retreive the values without hard writing the "id" and "secret" values, we can use environment variables.

      TF_VAR_client_id=$(az keyvault secret show --name "serprinId" --vault-name "KeyVaultDemoAzureInfra" --query value -o tsv)

      TF_VAR_client_secret=$(az keyvault secret show --name "serprinSecret" --vault-name "KeyVaultDemoAzureInfra" --query value -o tsv)

      ARM_ACCESS_KEY=$(az keyvault secret show --name "tstateAKey" --vault-name "KeyVaultDemoAzureInfra" --query value -o tsv)

2- Running `terraform init` and `terraform apply`

- On the **infrastructure-azure** folder, we can review the `main.tf` file, which contains the Terraform Backend configuration, in case you have a different parameters for your infrastructure you can moddify them for a propper custom deployment. You can leave it all as it is if you just want to replicate this demo.

- Navigate to the **infrastructure-azure** folder, once we are in the folder, run the command `terraform init` so Terraform can start downloading the necessary files in order to execute the next commands. 

- Here we can use `terraform plan` in case we want to view the infrastructure plan to review changes that will happen when we run the next step.

- Once we are sure the infrastructure contains everything we want, execute `terraform apply`, once we are prompted to confirm the desired infrastructure, proceed to type `yes` in the terminal. 

3- Deploying the apps in the Azure Kubernetes Cluster

- On the terminal, run the following command in order to connect to your Kubernetes Cluster, make sure to type your `resource group` and your `kluster name`:

      az aks get-credentials --resource-group demo-infra --name myAKSCluster



  Now we can see that our cluster is running with the command `kubectl get nodes`.

  ![az-get-cred](/infra-doc/aks-get-cred.png)

- On the root folder, there is a folder named **apps-deployment**, this folder contains the Kubernetes manifests with a sample application we can use to run and test our cluster. Dont navigate to this folder, stay on the root on your terminal. 


  Using the command `kubectl apply -f apps-deployment`, the Kubernetes manifests will deploy the sample application. 
  We can view our pods using the command `kubectl get pods`

  ![](/infra-doc/kube-apply.png)
  
  

- We can view our services and the `external-ip` address using the command `kubectl get svc`, copy the `EXTERNAL-IP` address and paste it in your browser to see our application working. 

  ![](/infra-doc/external-ip.png)

Now you should be able to acces the app, if you didn't make any changes to the app the `username` is `admin101` and the `password` is `password101`. 

![](/infra-doc/app-running-1.png)

It's a simple app where you can create and manage users to access it.

![](/infra-doc/app-running-2.png)