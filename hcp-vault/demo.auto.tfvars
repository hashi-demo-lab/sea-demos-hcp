deployment_name       = "aaron-hcp_vault-demo-"
owner                 = "aarone"
ttl                   = "300"
enable_cts_aws        = false
hcp_region            = "ap-southeast-2"
hcp_client_id         = ""
hcp_client_secret     = ""
aws_region            = "ap-southeast-2"
aws_key_pair_key_name = "vault-deploy"

# terraform cloud workspace onboarding vairables
tfc_organization    = "hashi-demos-apj"
github_organization = "hashicorp-demo-lab"
tfc_project         = "Default Project"
organization        = "hashi-demos-apj"
workspace_name      = "demo-hcp-vault-aws-auth"
agent_pool_name     = "AaronPool"
vcs_repo = {
  "identifier" : "hashicorp-demo-lab/demo-hcp",
  "branch" : "main",
  "ingress_submodules" : null,
  "oauth_token_id" : "ot-EEzS6zKkh8tEBC7o"
}