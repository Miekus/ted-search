module "Network" {
  source                    = "./modules/network"
  vpcCidrBlock              = var.vpcCidrBlock
  listOfSubnets             = var.listOfSubnets
  backendPortNumber         = var.backendPortNumber
  frontendPortNumber        = var.frontendPortNumber
}

module "Iam" {
  source                    = "./modules/iam"
}

module "Compute" {
  depends_on = [
    module.Network,
    module.Iam
  ]
  source                    = "./modules/compute"
  prodProfileName           = module.Iam.prodProfileName
  frontendSecurityGroupIds  = module.Network.frontendSecurityGroupIds
  backednSecurityGroupIds   = module.Network.backednSecurityGroupIds
  listOfCreatedSubnetsIds   = module.Network.listOfCreatedSubnetsIds
}