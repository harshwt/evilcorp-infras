variable "environment" {
  default = "production"
}

variable "instance_type" {
  default = "m5.xlarge"
}

variable "min_nodes" {
  default = 3
}

variable "max_nodes" {
  default = 12
}
