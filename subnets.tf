resource "aws_subnet" "subnet_for_ecs" {
  cidr_block = "${cidrsubnet(aws_vpc.vpc_for_ecs.cidr_block,4,1)}"
  vpc_id = "${aws_vpc.vpc_for_ecs.id}"
  availability_zone = "eu-west-2a"
}

resource "aws_route_table_association" "gateway_to_subnet" {
  route_table_id = "${aws_route_table.route_traffic_to_ig.id}"
  subnet_id = "${aws_subnet.subnet_for_ecs.id}"
}