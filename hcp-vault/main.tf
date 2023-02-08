locals {
  deployment_id = lower("${var.deployment_name}-${random_string.suffix.result}")
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

// hashicorp cloud platform (hcp) infrastructure

module "hcp-hvn" {
  source = "./modules/hcp"

  region                     = var.aws_region
  deployment_id              = local.deployment_id
  cidr                       = var.hcp_hvn_cidr
  aws_vpc_cidr               = var.aws_vpc_cidr
  aws_tgw_id                 = module.infra-aws.tgw_id
  aws_ram_resource_share_arn = module.infra-aws.ram_resource_share_arn
}

// amazon web services (aws) infrastructure

module "infra-aws" {
  source = "./modules/aws"

  region                      = var.aws_region
  owner                       = var.owner
  ttl                         = var.ttl
  deployment_id               = local.deployment_id
  key_pair_key_name           = var.aws_key_pair_key_name
  vpc_cidr                    = var.aws_vpc_cidr
  public_subnets              = var.aws_public_subnets
  private_subnets             = var.aws_private_subnets
  eks_cluster_version         = var.aws_eks_cluster_version
  eks_cluster_service_cidr    = var.aws_eks_cluster_service_cidr
  eks_worker_instance_type    = var.aws_eks_worker_instance_type
  eks_worker_desired_capacity = var.aws_eks_worker_desired_capacity
  hcp_hvn_provider_account_id = module.hcp-hvn.provider_account_id
  hcp_hvn_cidr                = var.hcp_hvn_cidr
  consul_serf_lan_port        = var.consul_serf_lan_port
}

// hcp vault

module "hcp-vault" {
  source = "./modules/vault/"

  deployment_name = var.deployment_name
  hvn_id          = module.hcp-hvn.id
  tier            = var.hcp_vault_tier
}