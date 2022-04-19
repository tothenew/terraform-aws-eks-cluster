# terraform-aws-eks-cluster

## EKS Cluster

This Terraform code snippet is used to launch a EKS Cluster.

## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Terraform is [installed](#software-dependencies) on the machine where Terraform is executed.
2. Make sure you had access to launch the resources in aws.


### Software Dependencies
### Terraform
- [Terraform](https://www.terraform.io/downloads.html) 1.0.x



## Install

### Terraform
Be sure you have the correct Terraform version (1.0.x), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

## File structure
The project has the following folders and files:

- /: Root folder
- /main.tf: Main file for this module, contains all the resources to create
- /provider.tf: File which will store the information about provider
- /variables.tf: All the variables for the module
- /outputs.tf: The outputs of the module
- /README.md: This file
- terrafrom.tfvars: Varaible files
 
## Usage

### Step 1: Clone the repo
### Step 2: Then perform the following commands in the root folder:

- `terraform init` to get the plugins
- `terraform plan --var-file="terraform.tfvars"` to see the infrastructure plan
- `terraform apply --var-file="terraform.tfvars"` to apply the infrastructure build
- `terraform destroy --var-file="terraform.tfvars"` to destroy the built infrastructure

Note: We will require the following values in order to execute the code successfully: 
- VPC Security Group IDs
- Subnet Ids

## Providers
| Name | Version |
|------|---------|
| aws  | 4.5.0 |

## Resources

| Name | Type |
|------|------|
| aws_eks_cluster  | resource |
| aws_iam_role | resource |
| aws_iam_role_policy_attachment | resource |
| aws_cloudwatch_log_group | resource |
| aws_security_group | resource |
| aws_security_group_rule | resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_name |  | `string` | n/a | yes |
| cluster_subnet_ids |  | `list(string)` | n/a | yes |
| cluster_role_name |  | `string` | n/a | yes |
| enabled_cluster_log_types |  | `list(string)` | n/a | yes |
| cluster_endpoint_private_access |  | `bool` | n/a | yes |
| cluster_endpoint_public_access |  | `bool` | n/a | yes |
| cluster_endpoint_public_access_cidrs |  | `list(string)` | n/a | yes |
| create_cloudwatch_log_group |  | `bool` | n/a | yes |
| cloudwatch_log_group_log_retention_in_days |  | `number` | n/a | yes |
| cluster_security_group_description |  | `string` | n/a | yes |
| cluster_security_group_use_name_prefix |  | `string` | n/a | yes |
| create_cluster_security_group |  | `bool` | n/a | yes |
