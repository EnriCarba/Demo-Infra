# Configure the Terraform Remote Backend
For the following configuration, I choosed the method that can be found in the [official Microsoft Azure documentation](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=terraform). 

In order to create a better management of the infrastructure, the **Terraform Backend** will be managed in a separated folder. 

---
1- In the folder named **backend**, create a terraform file to configure the backend using the Microsoft Documentation.

![terraform configuration file](/infra-doc/terraform-conf.png)

Run the `terraform init` and `terraform apply` commands in order to create an isolated resource group for the **Terraform State**.

---
2- On your main file (the `main.tf` file on `infrastructure-azure` folder) fill the necessary fields in the Terraform Configuration block:

![terraform configuration block](/infra-doc/terraform-backend.png)

---
3- Once the configuration block is filled with the necessary information, run the following commands `terraform init` and `terraform apply`.

---
There are other methods to configure the Terraform Backend, but this method can be stored for future purposes. 