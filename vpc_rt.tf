resource "aws_internet_gateway" "nagigw" {
  vpc_id = aws_vpc.nagvpc.id
  tags = {
    Name = "nagigw"
  }
}
resource "aws_route_table" "vpc_rt" {
  vpc_id = aws_vpc.nagvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nagigw.id
  }
}

resource "aws_route_table_association" "vpc_rt_a" {
  count          = 2
  subnet_id      = aws_subnet.nagsubnets[count.index].id
  route_table_id = aws_route_table.vpc_rt.id
}

