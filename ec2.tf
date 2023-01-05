/*provider "aws" {
    region = "us-east-1"
}*/
resource "aws_instance" "my_server"{
    count = "${var.instance}"
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    security_groups = ["scq_name"]
    user_data = <<-EOF
              #!/bin/bash
              sudo apt ubuntu -y
              sudo apt install git  -y
              sudo apt install openjdk-11*  -y
              curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
               /usr/share/keyrings/jenkins-keyring.asc > /dev/null
              echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
               https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
               /etc/apt/sources.list.d/jenkins.list > /dev/null
              sudo apt-get update -y
              sudo apt-get install jenkins -y
              sudo systemctl start jenkins
              sudo apt install docker.io -y
              sudo apt systemctl start docker
              EOF
    key_name = "newkeypair"
   # vpc_id = "${aws_vpc.myvpc.id}"
    subnet_id = "${aws_subnet.mypubsub.id}"
    depends_on = [
      aws_security_group.my_scq
    ]
    tags = {
      Name = "ec2server"
    }
}
