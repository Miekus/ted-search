resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.VPC.id

    tags = {
        Name = "Mateusz_Kiszka_T-S-RT-${terraform.workspace}"
        created_by = "Mateusz Kiszka"
        bootcamp = "poland1"
    }
}

resource "aws_route" "ROUTE" {
  route_table_id            = aws_route_table.RT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.GW.id
}

resource "aws_route_table_association" "RT-SN-ASSOCIATION" {
  count           = length(aws_subnet.Subnet)
  subnet_id       = aws_subnet.Subnet[count.index].id
  route_table_id  = aws_route_table.RT.id
}

