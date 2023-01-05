provider "aws" {
    region = "us-east-1"
}
 resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "myvpc"
  }
}
resource "aws_subnet" "mypubsub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "mypubsub"
  }
}
/*
resource "aws_subnet" "myprisub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
map_public_ip_on_launch = false

  tags = {
    Name = "myprisub"
  }
}
*/

resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "internetgw"
  }
}
resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygw.id
  }

/*  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.mygw.id
  } */

  tags = {
    Name = "myrt"
  }
}
rvbbbesource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.mypubsub.id
  route_table_id = aws_route_table.myrt.id
}
/*
resource "aws_eip" "myeip" {
  vpc = true
  depends_on                = [aws_internet_gateway.mygw]
}
resource "aws_nat_gateway" "mynat" {
  allocation_id = aws_eip.myeip.id
  subnet_id = aws_subnet.mypubsub.id
  tags = {
    Name = "mynat"
  }
}
resource "aws_route_table" "myrt2" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygw.id
  }

/*  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.mygw.id
  } */
/*
  tags = {
    Name = "myrt2"
  }
  resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.myprisub.id
  route_table_id = aws_route_table.myrt2.id
}
*/
