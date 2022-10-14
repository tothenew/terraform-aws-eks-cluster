# terraform-aws-eks-cluster

## EKS Cluster

This Terraform code snippet is used to launch a EKS Cluster.

## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Terraform is [installed](#software-dependencies) on the machine where Terraform is executed.
2. Make sure you had access to launch the resources in aws.


### Software Dependencies
### Terraform
- [Terraform](https://www.terraform.io/downloads.html) 1.2.x



## Install

### Terraform
Be sure you have the correct Terraform version (1.2.x), you can choose the binary here:
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
| cluster_name |  | `string` | yes | no |
| cluster_subnet_ids |  | `list(string)` | no | yes |
| cluster_role_name |  | `string` | yes | no |
| enabled_cluster_log_types |  | `list(string)` | yes | no |
| cluster_endpoint_private_access |  | `bool` | yes | no |
| cluster_endpoint_public_access |  | `bool` | yes | no |
| cluster_endpoint_public_access_cidrs |  | `list(string)` | yes | no |
| create_cloudwatch_log_group |  | `bool` | yes | no |
| cloudwatch_log_group_log_retention_in_days |  | `number` | yes | no |
| cluster_security_group_description |  | `string` | yes | no |
| cluster_security_group_use_name_prefix |  | `string` | yes | no |
| create_cluster_security_group |  | `bool` | yes | no |

## Terraform Module usage for creating eks cluster

### eks-cluster-module-with-custom-inputs

```
module "terraform-aws-eks-cluster" {
  source  = "../terraform-aws-eks-cluster"
  cluster_name = "eks-cluster"
  cluster_version = "1.23"
  cluster_role_name = "eks-cluster-role"
  cluster_subnet_ids = ["subnet-a", "subnet-b", "subnetc"]
  cluster_endpoint_private_access = false  
  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  vpc_id = "vpc-1234556abcdef"
  cluster_service_ipv4_cidr = "172.20.0.0/16"
  ip_family = "ipv4"
  create_cloudwatch_log_group = true
  cloudwatch_log_group_log_retention_in_days = 90
  create_cluster_security_group = true
  cluster_additional_security_group_ids = []
  cluster_security_group_description = "EKS cluster security group"
  cluster_security_group_name = "eks-cluster-sg"
  cluster_security_group_use_name_prefix = true
  environment = "dev"
  project = "eks-dev"
} 
```

### eks-cluster-with-minimum-inputs
```
module "terraform-aws-eks-cluster" {
  source  = "../terraform-aws-eks-cluster"
  cluster_subnet_ids = ["subnet-4a57cc07"]
} 
```

### eks-cluster-with-private-access
```
module "terraform-aws-eks-cluster" {
  source  = "../terraform-aws-eks-cluster"
  cluster_subnet_ids = ["subnet-4a57cc07"]
  cluster_endpoint_private_access = true
}
```

