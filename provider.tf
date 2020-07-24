provider "aws" {
  region = "us-east-2"
}

data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_vpc" "nagvpc" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "nagvpc"
  }
}

resource "aws_subnet" "nagsubnets" {
  count             = length(data.aws_availability_zones.azs.names)
  vpc_id            = aws_vpc.nagvpc.id
  availability_zone = element(data.aws_availability_zones.azs.names, count.index)
  cidr_block        = cidrsubnet(aws_vpc.nagvpc.cidr_block, 8, count.index)
  tags = {
    Name = "subnet-${count.index}"
  }
}
