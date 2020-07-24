resource "aws_eip" "myeip" {
  count    = length(aws_subnet.nagsubnets)
  vpc      = true
  instance = element(aws_instance.naginstance.*.id, count.index)

  tags = {
    Name = "nagvpc-eip-${count.index + 1}"
  }
}

