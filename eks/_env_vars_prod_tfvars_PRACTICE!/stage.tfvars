variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "SSH EC2 Key"
  type        = string
  default     = "tf_key_stage"
}