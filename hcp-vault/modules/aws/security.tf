module "sg-ssh" {
  source = "terraform-aws-modules/security-group/aws"
  version     = "4.9.0"

  name        = "${var.deployment_id}-ssh"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block}"
    }
  ]
}

module "sg-consul" {
  source = "terraform-aws-modules/security-group/aws"
  version     = "4.9.0"

  name        = "${var.deployment_id}-consul"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "consul-partition-https-tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block}"
    },
    {
      from_port   = 8300
      to_port     = 8301
      protocol    = "tcp"
      description = "consul-rpc-lan-serf-gosspip-tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block}"
    },
    {
      from_port   = 8300
      to_port     = 8301
      protocol    = "udp"
      description = "consul-lan-serf-gosspip-udp"
      cidr_blocks = "${module.vpc.vpc_cidr_block}"
    },
    {
      from_port   = 8443
      to_port     = 8443
      protocol    = "tcp"
      description = "consul-mesh-gateways"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 8500
      to_port     = 8502
      protocol    = "tcp"
      description = "consul-http-https-api-tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block}"
    },
    {
      from_port   = 8600
      to_port     = 8600
      protocol    = "tcp"
      description = "consul-dns-tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block}"
    },
    {
      from_port   = 8600
      to_port     = 8600
      protocol    = "udp"
      description = "consul-dns-udp"
      cidr_blocks = "${module.vpc.vpc_cidr_block}"
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "consul-connect-injector-tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block}"
    },
    {
      from_port   = 20000
      to_port     = 21255
      protocol    = "tcp"
      description = "consul-connect-envoy-tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block}"
    },
    {
      from_port   = var.consul_serf_lan_port
      to_port     = var.consul_serf_lan_port
      protocol    = "tcp"
      description = "consul-lan-serf-gosspip-tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block}"
    },
    {
      from_port   = var.consul_serf_lan_port
      to_port     = var.consul_serf_lan_port
      protocol    = "udp"
      description = "consul-lan-serf-gosspip-udp"
      cidr_blocks = "${module.vpc.vpc_cidr_block}"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "any-any"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}