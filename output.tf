output "ec2_pulic_ip" {
    description = "public_ip_our_ec2_instance"
    value = "${aws_instance.my_server.public_ip}"
}
