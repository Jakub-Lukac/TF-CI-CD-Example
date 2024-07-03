# env variables HAVE TO be populated with default value, otherwise they wont be populated with values from the terraform.yml pipeline

variable "env_client_id" {
  type    = string
  default = ""
}

variable "env_client_secret" {
  type    = string
  default = ""
}

variable "env_subscription_id" {
  type    = string
  default = ""
}

variable "env_tenant_id" {
  type    = string
  default = ""
}
