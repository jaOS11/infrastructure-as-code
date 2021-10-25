
#Create rds subnet group

resource "aws_db_subnet_group" "dbsubnet" {
  name = "dbsubnet"
  subnet_ids = "${aws_subnet.privatesubnets.*.id}"
}

#Parameter Group
resource "aws_db_parameter_group" "group6" {
  name   = "rds-pg"
  family = "mysql5.7"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

#Create RDS

resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "rdsMulti"
  identifier           = "dbmulti"
  username             = "g6rds"
  password             = "group6fhict"
  parameter_group_name = "${aws_db_parameter_group.group6.id}"
  skip_final_snapshot  = true
  db_subnet_group_name = "${aws_db_subnet_group.dbsubnet.id}"
  port = 3306
  publicly_accessible = false
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  
  tags = {
    Name = "database"
    Project = "Multi"
  }
}
