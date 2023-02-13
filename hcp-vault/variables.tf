// generic variables

variable "deployment_name" {
  description = "Deployment name, used to prefix resources"
  type        = string
  default     = ""
}

// hashicorp identification variables

variable "owner" {
  description = "Resource owner identified using an email address"
  type        = string
  default     = ""
}

variable "ttl" {
  description = "Resource TTL (time-to-live)"
  type        = number
  default     = 48
}

// hashicorp cloud platform (hcp) variables

variable "hcp_region" {
  description = "HCP region"
  type        = string
  default     = ""
}

variable "hcp_client_id" {
  description = "HCP client id"
  type        = string
  default     = ""
}

variable "hcp_client_secret" {
  description = "HCP client secret"
  type        = string
  default     = ""
}

variable "hcp_hvn_cidr" {
  description = "HCP HVN cidr"
  type        = string
  default     = "172.25.16.0/20"
}

variable "hcp_vault_tier" {
  description = "HCP Vault cluster tier"
  type        = string
  default     = "dev"
}

variable "hcp_boundary_init_user" {
  description = "Initial admin user"
  type        = string
  default     = "admin"
}

variable "hcp_boundary_init_pass" {
  description = "Initial admin user password"
  type        = string
  default     = "HashiCorp1!"
}

// amazon web services (aws) variables

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "aws_key_pair_key_name" {
  description = "Key pair name"
  type        = string
  default     = ""
}

variable "aws_vpc_cidr" {
  description = "AWS VPC CIDR"
  type        = string
  default     = "10.200.0.0/16"
}

variable "aws_private_subnets" {
  description = "AWS private subnets"
  type        = list(any)
  default     = ["10.200.20.0/24", "10.200.21.0/24", "10.200.22.0/24"]
}

variable "aws_public_subnets" {
  description = "AWS public subnets"
  type        = list(any)
  default     = ["10.200.10.0/24", "10.200.11.0/24", "10.200.12.0/24"]
}

variable "aws_eks_cluster_version" {
  description = "AWS EKS cluster version"
  type        = string
  default     = "1.22"
}

variable "aws_eks_cluster_service_cidr" {
  description = "AWS EKS cluster service cidr"
  type        = string
  default     = "172.20.0.0/18"
}

variable "aws_eks_worker_instance_type" {
  description = "AWS EKS EC2 worker node instance type"
  type        = string
  default     = "m5.large"
}

variable "aws_eks_worker_desired_capacity" {
  description = "AWS EKS desired worker capacity in the autoscaling group"
  type        = number
  default     = 2
}

variable "aws_ami_hashicups_product_api_db" {
  description = "AWS AMI for hashicups product-api-db"
  type        = string
  default     = "ami-082c7add2ac0c19f6"
}

// google cloud platform (gcp) variables

variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = ""
}

variable "gcp_project_id" {
  description = "GCP project id"
  type        = string
  default     = ""
}

variable "gcp_private_subnets" {
  description = "GCP private subnets"
  type        = list(any)
  default     = ["10.210.20.0/24", "10.210.21.0/24", "10.210.22.0/24"]
}

variable "gcp_gke_pod_subnet" {
  description = "GCP GKE pod subnet"
  type        = string
  default     = "10.211.20.0/23"
}

variable "gcp_gke_cluster_service_cidr" {
  description = "GCP GKE cluster service cidr"
  type        = string
  default     = "172.20.0.0/18"
}

### workspace variables

# Organization level variables
variable "organization" {
  description = "TFC Organization to build under"
  type        = string
}

# Workspace level variables
variable "workspace_name" {
  description = "Name of the workspace to create"
  type        = string
}

variable "workspace_description" {
  description = "Description of workspace"
  type        = string
  default     = ""
}

variable "workspace_terraform_version" {
  description = "Version of Terraform to run"
  type        = string
  default     = "latest"
}

variable "workspace_tags" {
  description = "Tags to apply to workspace"
  type        = list(string)
  default     = []
}


## VCS variables (existing VCS connection)
variable "vcs_repo" {
  description = "(Optional) - Map of objects that will be used when attaching a VCS Repo to the Workspace. "
  default     = {}
  type        = map(string)
}

variable "workspace_vcs_directory" {
  description = "Working directory to use in repo"
  type        = string
  default     = "root_directory"
}

# Variables
variable "variables" {
  description = "Map of all variables for workspace"
  type        = map(any)
  default = {
    "CLOUD_PROVIDER_AWS" : {
      "value" : "true",
      "description" : "",
      "category" : "env",
      "sensitive" : false,
      "hcl" : false
    },
    "VAULT_PATH" : {
      "value" : "aws-dynamic-credentials",
      "description" : "",
      "category" : "env",
      "sensitive" : false,
      "hcl" : false
    },
    "TFC_VAULT_APPLY_ROLE" : {
      "value" : "vault-demo-assumed-role",
      "description" : "",
      "category" : "env",
      "sensitive" : false,
      "hcl" : false
    },
    "TFC_VAULT_PLAN_ROLE" : {
      "value" : "vault-demo-assumed-role",
      "description" : "",
      "category" : "env",
      "sensitive" : false,
      "hcl" : false
    },
    "TFC_WORKLOAD_IDENTITY_AUDIENCE" : {
      "value" : "vault.workload.identity",
      "description" : "",
      "category" : "env",
      "sensitive" : false,
      "hcl" : false
    },
    "VAULT_ADDR" : {
      "value" : "http://localhost:8200",
      "description" : "",
      "category" : "env",
      "sensitive" : false,
      "hcl" : false
    }
  }
}

variable "create_project" {
  description = "(Optional) Boolean that allows for the creation of a Project in Terraform Cloud that the workspace will use. This feature is in beta and currently doesn't have a datasource"
  type        = bool
  default     = false
}

variable "project_name" {
  description = "(Optional) Name of the Project that is created in Terraform Cloud if var.create_project is set to true. Note this is currently in beta"
  type        = string
  default     = ""
}

variable "assessments_enabled" {
  description = "(Optional) Boolean that enables heath assessments on the workspace"
  type        = bool
  default     = false
}

# # RBAC
# ## Workspace owner (exising org user)
# variable "workspace_owner_email" {
#   description = "Email for the owner of the account"
#   type        = string
# }

## Additional read users (existing org user)
variable "workspace_read_access_emails" {
  description = "Emails for the read users"
  type        = list(string)
  default     = []
}

## Additional write users (existing org user)
variable "workspace_write_access_emails" {
  description = "Emails for the write users"
  type        = list(string)
  default     = []
}

## Additional plan users (existing org user)
variable "workspace_plan_access_emails" {
  description = "Emails for the plan users"
  type        = list(string)
  default     = []
}

variable "agent_pool_name" {
  type        = string
  description = "(Optional) Name of the agent pool that will be created or used"
  default     = null
}

variable "workspace_agents" {
  type        = bool
  description = "(Optional) Conditional that allows for the use of existing or new agents within a given workspace"
  default     = true
}

variable "workspace_auto_apply" {
  type        = string
  description = "(Optional)  Setting if the workspace should automatically apply changes when a plan succeeds."
  default     = true
}

variable "execution_mode" {
  type        = string
  description = "Defines the execution mode of the Workspace. Defaults to remote"
  default     = "agent"
}

variable "remote_state" {
  type        = bool
  description = "(Optional) Boolean that enables the sharing of remote state between this workspace and other workspaces within the environment"
  default     = false
}

variable "remote_state_consumers" {
  type        = set(string)
  description = "(Optional) Set of remote IDs of the workspaces that will consume the state of this workspace"
  default     = [""]
}