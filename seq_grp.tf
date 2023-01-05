/*provider "aws" {
    region = "us-east-1"
  
}*/

resource "aws_security_group" "my_scq" {
  name        = "scq_name"
  description = "Allow http inbound and outbound traffic"
  vpc_id = "${aws_vpc.myvpc.id}"

  ingress {
    description      = "Allow http inbound and outbound traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 8080
    
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }
/*
  depends_on = [
    aws_vpc.myvpc
  ]
    */
  
  tags = {
    Name = "new_scq"
  }
}
