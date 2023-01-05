variable "ami"{
    description = "amazon_meachine_image"
    default = "ami-0b93ce03dcbcb10f6"
}
variable "instance_type"{
    description = "instance_type like t2.micro"
    default = "t2.micro" 
}
variable "instance"{
    description = "how manyinstance do you want"
    default = "1"
}
