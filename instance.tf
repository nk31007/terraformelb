resource "aws_instance" "naginstance" {
  count                       = length(aws_subnet.nagsubnets)
  subnet_id                   = element(aws_subnet.nagsubnets.*.id, count.index)
  key_name                    = "nagkey"
  associate_public_ip_address = true
  ami                         = "ami-0a54aef4ef3b5f881"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.sg.id]
  user_data                   = file("apache_setup.sh")
  tags = {
    Name = "instance-${count.index + 1}"
  }
}



