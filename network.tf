provider "aws" {
  
 access_key = "${var.aws_access_key}"
 secret_key = "${var.aws_secret_key}"
 region = "${var.region}"
}

#using data source with tag name to pick existing vpc and pupblic_subnet

data "aws_vpc" "selected" {
  tags = {
    Name = "${var.vpc}"
  }
}

data "aws_subnet" "public" {
  vpc_id = "${data.aws_vpc.selected.id}"
  tags = {
    Name = "${var.subnet_id}"
  }
}

# CREATE TWO PRIVATE SUBNETS IN EXISTING VPC

resource "aws_subnet" "subnet_priv1" {

   vpc_id = "${data.aws_vpc.selected.id}"
   cidr_block = "${var.private_subnet_1a}"
   availability_zone = "ap-south-1a"

  tags = {
    Name = "${var.priv_subnet1}"
  }
}

resource "aws_subnet" "subnet_priv2" {

   vpc_id = "${data.aws_vpc.selected.id}"
   cidr_block = "${var.private_subnet_1b}"
   availability_zone = "ap-south-1b"

   tags = {
   Name = "${var.priv_subnet2}"
}
}

resource "aws_subnet" "subnet_priv3" {

   vpc_id = "${data.aws_vpc.selected.id}"
   cidr_block = "${var.private_subnet_1c}"
   availability_zone = "ap-south-1c"

   tags = {
   Name = "${var.priv_subnet3}"
}
}

#CREATE ELASTIC IP FOR NAT GW

resource "aws_eip" "eip" {
vpc      = true
}

#CREATE NAT GATEWAY IN EXISTING VPC

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${data.aws_subnet.public.id}"

  tags = {
    Name = "gw NAT"
  }
}

#CREATE ROUTE TABLE INCLUDE NAT

resource "aws_route_table" "route_NAT" {
  vpc_id = "${data.aws_vpc.selected.id}"
route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.gw.id}"
  }
 tags = {
 Name = "route_with_NAT"
}
}

#ASSOCIATE PRIVATE SUBNET WITH THIS ROUTE TABLE

resource "aws_route_table_association" "subnet-association1a" {
  subnet_id      = "${aws_subnet.subnet_priv1.id}"
  route_table_id = "${aws_route_table.route_NAT.id}"
}

resource "aws_route_table_association" "subnet-association1b" {
  subnet_id      = "${aws_subnet.subnet_priv2.id}"
  route_table_id = "${aws_route_table.route_NAT.id}"
}

resource "aws_route_table_association" "subnet-association1c" {
  subnet_id      = "${aws_subnet.subnet_priv3.id}"
  route_table_id = "${aws_route_table.route_NAT.id}"
}

#CREATE RDS PRIVATE SUBNET GROUPS USING ABOVE PRIVATE SUBNETS

resource "aws_db_subnet_group" "rds_subnet_groups" {
  name       = "priv_subnet_group"
  subnet_ids = ["${aws_subnet.subnet_priv1.id}", "${aws_subnet.subnet_priv2.id}", "${aws_subnet.subnet_priv3.id}"]

  tags = {
    Name = "DB_priv_subnet_group"
  }
}
