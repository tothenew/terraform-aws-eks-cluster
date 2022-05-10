provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project
    }  
}