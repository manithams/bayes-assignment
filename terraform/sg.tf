resource "aws_security_group" "k8s_common_http" {
  name   = "${var.environment}_k8s_common_http"
  vpc_id = module.vpc.vpc_id
  tags   = local.tags

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["${local.ingress_ips}"]
  }

  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["${local.ingress_ips}"]
  }
}