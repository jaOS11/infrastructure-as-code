#Security Groups
  resource "aws_security_group" "allow-ssh" {
    vpc_id      = aws_vpc.multivpc.id
    name        = "allow-ssh"
    description = "security group that allows ssh and all egress traffic"
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh"
    Project = "Multi"
  }
}

  resource "aws_security_group" "http-ssh" {
    vpc_id      = aws_vpc.multivpc.id
    name        = "http-ssh"
    description = "security group that allows http and all egress traffic"
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "http-ssh"
    Project = "Multi"
  }
}

# security group for application load balancer
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "allow incoming HTTP traffic only"
  vpc_id      = "${aws_vpc.multivpc.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sg"
    Project = "Multi"
  }
}

# security group for rds
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "allow incoming traffic for db"
  vpc_id      = "${aws_vpc.multivpc.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds_sg"
    Project = "Multi"
  }
}
