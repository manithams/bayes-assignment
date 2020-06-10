variable "cidr_ab" {
  type = map
  default = {
    dev = "172.22"
    qa          = "172.24"
    staging     = "172.26"
    prod  = "172.28"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

variable "environment" {
  type        = string
  description = "Options: dev, qa, staging, prod"
  default     = "prod"
}

data "aws_region" "current" {}

locals {

  availability_zones      = data.aws_availability_zones.available.names
  kubernetes_cluster_name = "${data.aws_region.current.name}.${var.environment}.kubernetes.msilva.com"
  kops_state_bucket_name  = "msilva-${var.environment}-kops-state"
  vpc_name                = "msilva-${var.environment}-vpc"
  ingress_ips             = "0.0.0.0/0"
  private_subnets = [
    "${lookup(var.cidr_ab, var.environment)}.1.0/24",
    "${lookup(var.cidr_ab, var.environment)}.2.0/24",
    "${lookup(var.cidr_ab, var.environment)}.3.0/24"
  ]

  database_subnets = [
    "${lookup(var.cidr_ab, var.environment)}.11.0/24",
    "${lookup(var.cidr_ab, var.environment)}.12.0/24",
    "${lookup(var.cidr_ab, var.environment)}.13.0/24"
  ]

  public_subnets = [
    "${lookup(var.cidr_ab, var.environment)}.64.0/24",
    "${lookup(var.cidr_ab, var.environment)}.65.0/24",
    "${lookup(var.cidr_ab, var.environment)}.66.0/24"
  ]

  tags = {
    "environment" = "${var.environment}"
    "terraform"   = true
  }
}

