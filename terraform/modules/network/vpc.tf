resource "aws_vpc" "VPC" {
    cidr_block              = var.vpcCidrBlock
    instance_tenancy        = "default"
    enable_dns_hostnames    = true

    tags = {
        Name                = "Mateusz_Kiszka_T-S-VPC-${terraform.workspace}"
        created_by          = "Mateusz Kiszka"
        bootcamp            = "poland1"
    }
}
