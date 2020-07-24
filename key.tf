resource "aws_key_pair" "kp" {
  key_name   = "nagkey"
  public_key = file("nagpub.txt")
  tags = {
    Name = "nagkey"
  }
}

