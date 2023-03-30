variable "ecr_name" {
  type        = any  
  description = "The ECR repository to create and deploy Tuvoli API images to"
  default     = null
}

variable "image_tag_mutability" {
  type        = string
  description = "Repository tag mutability"
  default     = "MUTABLE"
}

variable "scan_on_push" {
  type        = bool
  description = "Whether images are scanned when pushed to repository or not"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
