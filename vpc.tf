resource "aws_vpc" "vpc_for_ecs" {
  cidr_block = "172.10.20.0/24"
  enable_dns_hostnames = true
  tags {
    Names = "vpc_for_web_app"
  }
}