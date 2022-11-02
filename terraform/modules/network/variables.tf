variable "vpcCidrBlock" {
  type        = string
  description = "cidr block size for vpc"
}
variable "listOfSubnets" {
  type              = list(object({ 
  cidr-block        = string
  availability_zone = string
  }))
  description = "List of subnets, if cidr block will be empty then will be generated automatic"
} 
variable "backendPortNumber" {
  type        = number
  description = "Backend port number"
}
variable "frontendPortNumber" {
  type        = number
  description = "frontend port number"
}