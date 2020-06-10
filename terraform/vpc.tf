module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "2.38.0"
  name            = "${local.vpc_name}"
  cidr            = "${lookup(var.cidr_ab, var.environment)}.0.0/16"
  azs             = local.availability_zones
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway = true
  #enable_vpn_gateway = true

  tags = {
  Terraform   = "true"
  Environment = "${var.environment}"
  #This is so kops knows that the VPC resources can be used for k8s
  "kubernetes.io/cluster/${local.kubernetes_cluster_name}" = "shared"
  }

  private_subnet_tags = {
  "kubernetes.io/role/internal-elb" = true
  }

  public_subnet_tags = {
  "kubernetes.io/role/elb" = true
  }
} 