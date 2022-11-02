resource "aws_internet_gateway" "GW" {
  vpc_id = aws_vpc.VPC.id

    tags = {
        Name = "Mateusz_Kiszka_T-S-GW-${terraform.workspace}"
        created_by = "Mateusz Kiszka"
        bootcamp = "poland1"
    }
}