resource "aws_lb" "naglb" {
  name                       = "naglb"
  subnets                    = aws_subnet.nagsubnets.*.id
  internal                   = false
  security_groups            = [aws_security_group.sg.id]
  enable_deletion_protection = true

  tags = {
    Name = "naglb"
  }
}


resource "aws_lb_target_group" "nagtgrp" {
  name     = "nagtgrp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.nagvpc.id
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "naglbattach" {
  count            = length(aws_instance.naginstance)
  target_group_arn = aws_lb_target_group.nagtgrp.arn
  target_id        = aws_instance.naginstance[count.index].id
  port             = 80
}



resource "aws_lb_listener" "naglblistener" {
  load_balancer_arn = aws_lb.naglb.arn
  protocol          = "HTTP"
  port              = 80
  default_action {
    target_group_arn = aws_lb_target_group.nagtgrp.arn
    type             = "forward"
  }
}

/*

resource "aws_lb_target_group_attachment" "naglbattach" {
  target_group_arn = aws_lb_target_group.nagtgrp.arn
  target_id        = aws_instance.test.id
  port             = 80
}



resource "aws_lb_listener" "naglblistener" {
load_balancer_arn=aws_lb.naglb.arn
protocol="HTTP"
default_action {
target_group_arn=aws_lb_target_group.nagtgrp.arn
type="forward"
}
}
*/
