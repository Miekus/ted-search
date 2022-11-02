resource "aws_subnet" "Subnet" {
    count               = length(var.listOfSubnets)

    vpc_id              = aws_vpc.VPC.id
    cidr_block          = cidrsubnet(var.vpcCidrBlock,4, index(var.listOfSubnets, var.listOfSubnets[count.index]) )
    availability_zone   = var.listOfSubnets[count.index].availability_zone

    tags = {
        Name            = "Mateusz_Kiszka_T-S-SubNet-${var.listOfSubnets[count.index].availability_zone}-${terraform.workspace}"
        created_by      = "Mateusz Kiszka"
        bootcamp        = "poland1"
    }
}