output "ec2_public_ip" {
    description = "public_ip_our_ec2_instance"
    value = "${aws_instance.my_server.public_ip}"
}
