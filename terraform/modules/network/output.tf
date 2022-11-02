output "listOfCreatedSubnetsIds" {
  value = "${aws_subnet.Subnet.*.id}"
}
output "frontendSecurityGroupIds" {
  value = "${aws_security_group.SG-BE.*.id}"
}
output "backednSecurityGroupIds" {
  value = "${aws_security_group.SG-FE.*.id}"
}