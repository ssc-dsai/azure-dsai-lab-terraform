# Azure Lab Environment Terraform

<!-- ![Alt text](docs/AWS-ECS-Blue-Green.jpeg?raw=true) -->


The overall flow for this module is:

* Create a storage account to store Terraform state (To do manually before hand)
* Create an App Service infrastucture in a modular manner
* Deploy the infrastructure incrementally

## Dependencies

* [Azure-CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
* [Terraform](https://www.terraform.io/downloads.html)

## Workflow

1. Create terraform.tfvars based on example template provider.

2. Ensure you loged in Azure using the azure-cli so that Terraform can apply changes.

```sh
az login
```

3. Initialize and set the Terraform backend configuration parameters for the Azure provider.

```sh
terraform init
```

> Note: You will have to specify your own storage account name for where to store the Terraform state.

4. Create an execution plan and save the generated plan to a file.

```sh
terraform plan -out plan
```

5. Apply the changes.

```sh
terraform apply
```