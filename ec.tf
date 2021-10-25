#EC2 instances
#On public subnet ec2
  resource "aws_instance" "webserver" {
    ami           = "ami-05f7491af5eef733a"
    instance_type = "t2.micro"

    subnet_id = aws_subnet.publicsubnets[0].id

    vpc_security_group_ids = [aws_security_group.http-ssh.id]

    key_name = aws_key_pair.publickey.key_name

    provisioner "file" {
      source = "nginx.sh"
      destination = "/tmp/nginx.sh" 
  } 

    provisioner "remote-exec" {
      inline = [
            "chmod +x /tmp/nginx.sh",
            "sudo /tmp/nginx.sh"
        ]
   }
      connection {
        user = "${var.ec2_user}"
        private_key = "${file("${var.private_key_public}")}"
        host = "${aws_instance.webserver.public_ip}"
     }
  
    tags = {
      Name = "webserver"
      Project = "Multi"
  }
}

  resource "aws_instance" "bastion" {
    ami           = "ami-05f7491af5eef733a"
    instance_type = "t2.micro"

    subnet_id = aws_subnet.publicsubnets[0].id

    vpc_security_group_ids = [aws_security_group.allow-ssh.id]

    key_name = aws_key_pair.publickey.key_name

    tags = {
      Name = "bastion"
      Project = "Multi"
  }
}

#On private subnets
  resource "aws_instance" "backend" {
    ami           = "ami-05f7491af5eef733a"
    instance_type = "t2.micro"

    subnet_id = aws_subnet.privatesubnets[0].id

    vpc_security_group_ids = [aws_security_group.allow-ssh.id]

    key_name = aws_key_pair.privatekey.key_name
    
    tags = {
      Name = "backend"
      Project = "Multi"
  }
}

#Private keys creation
  resource "aws_key_pair" "publickey" {
    key_name   = "publickey"
    public_key = file(var.public_key_public)
}

  resource "aws_key_pair" "privatekey" {
    key_name   = "privatekey"
    public_key = file(var.public_key_private)
}
