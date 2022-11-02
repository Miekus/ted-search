variable "listOfCreatedSubnetsIds" {
  type = list(string)
}
variable "frontendSecurityGroupIds" {
  type = list(string)
}
variable "backednSecurityGroupIds" {
  type = list(string)
}
variable "prodProfileName" {
  type = string
}