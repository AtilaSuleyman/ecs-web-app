resource "aws_internet_gateway" "ecs_internet_connectivity" {
  vpc_id = "${aws_vpc.vpc_for_ecs.id}"
  tags {
    Name = "ecs-internet-gateway"
  }
}

resource "aws_route_table" "route_traffic_to_ig" {
  vpc_id = "${aws_vpc.vpc_for_ecs.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ecs_internet_connectivity.id}"
  }
  tags {
    Name = "route-traffic-to-ig"
  }
}
