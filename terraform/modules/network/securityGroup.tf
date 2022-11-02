resource "aws_security_group" "SG-BE" {
  name        = "Mateusz_Kiszka_T-S-SG-BE-${terraform.workspace}"
  description = "Describe tafic rules of back end"
  vpc_id      = aws_vpc.VPC.id

  ingress {
    description      = "HTTP"
    from_port        = var.frontendPortNumber
    to_port          = var.frontendPortNumber
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
      Name        = "Mateusz_Kiszka_T-S-SG-BE"
      created_by  = "Mateusz Kiszka"
      bootcamp    = "poland1"
  }
}

resource "aws_security_group" "SG-FE" {
  name        = "Mateusz_Kiszka_T-S-SG-FE-${terraform.workspace}"
  description = "Descripe trafic rules of front-end"
  vpc_id      = aws_vpc.VPC.id

  ingress {
    description      = "HTTP"
    from_port        = var.backendPortNumber
    to_port          = var.backendPortNumber
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
      Name        = "Mateusz_Kiszka_T-S-SG-FE"
      created_by  = "Mateusz Kiszka"
      bootcamp    = "poland1"
  }
}
