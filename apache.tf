resource "aws_instance" "apacheweb_server" {
  ami           = "ami-8258965231478"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.helloworldSecurityGroup.id]
  subnet_id = "subnet-0987" 

  provisioner "remote-exec" {
    inline = [
    "sudo yum -y install httpd & sudo systemctl start httpd",
    "echo '<html><head><title>Hello World</title></head><body><h1>Hello World!</h1></body></html>' >index.html",
    ]
  }
  tags = {
    Name = "helloworldApache EC2"
  }
}

resource "aws_lb" "front_end" {
    #arn = ""
    name = "LBapache"
  
  tags = {
    Name = "loadbalancer Apache"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      }
  }
  tags = {
    Name = "loadbalancer listener redirect HTTPS"
  }
}
resource "aws_security_group" "helloworldSecurityGroup" {
   ingress {
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "inbound security group for 443"
  }
 }