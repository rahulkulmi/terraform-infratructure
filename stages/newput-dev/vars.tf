variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The region to deploy resources"
}

variable "access_key" {
  description = "My AWS access key"
}

variable "secret_key" {
  description = "My AWS secret key"
}

variable "stage" {
  default = "dev"
}

variable "cluster_name" {
  type        = string
  default     = "newput-dev"
  description = "The name of the ECS cluster"
}

variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to resources"
}

variable "vpc_name" {
  type        = string
  default     = "newput-dev"
  description = "The name of the vpc"
}

variable "cidr" {
  type        = string
  default     = "172.17.0.0/16"
  description = "The CIDR Block for the VPC."
}

variable "az_count" {
  type        = number
  default     = 2
  description = "The number of availability zones to use. The region must have at least this many AZs available."
}
/*
variable "production" {
  type        = bool
  default     = false
  description = "Describes if the desired output should be a production environment."
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = true
  description = "Should be true to enable DNS hostnames in the VPC"
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "Should be true to enable DNS support in the VPC"
}

variable "vpc_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags for the VPC"
}

variable "private_subnet_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags for private subnets"
}

variable "public_subnet_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags for public subnets"
}

### EC2 graylog server related variables
variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = "1"
}

variable "use_num_suffix" {
  description = "Always append numerical suffix to instance name, even if instance_count is 1"
  type        = bool
  default     = true
}

variable "graylog_server_security_group_names" {
  default = ["allow_all"]
}

variable "name" {
  description = "Name to be used for EC2"
  type        = string
  default     = "newput-graylog-4.3"
}

# security groups
variable "fc_integration_ips" {
  type        = list(string)
  description = "integration ips"
  default = [
    "192.169.0.0/32",
    "192.169.0.1/32",
    "192.169.0.2/32",
    "192.169.0.3/32",
    "192.169.0.4/32"
  ]
}
*/

## ecr_repository
variable "image_tag_mutability" {
  type        = string
  default     = "MUTABLE"
  description = "Repository tag mutability. Valid values are MUTABLE and IMMUTABLE"
}

variable "scan_on_push" {
  type        = bool
  default     = true
  description = "Whether images are scanned when pushed to repository or not"
}

variable "repository_names" {
  type        = list(string)
  description = "The ECR repository to create and deploy for ECR images"
  default = [
    "newput/node-terraform",
    "newput/react-terraform",
    "newput/lambda-terraform"
  ]
}

## Tag variables
variable "tags" {
  type        = map(string)
  default     = { "Terraform" = "true" }
  description = "Tags to apply to resources"
}

variable "repo" {
  default = "terraform-infrastructure"
}

variable "project" {
  default = "newput"
}

variable "app_version" {
  type        = string
  default     = null
  description = "Version of the application"
}
