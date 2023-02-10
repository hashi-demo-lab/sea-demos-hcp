data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "aws-ubuntu-apache"
  channel     = "latest"
}

data "hcp_packer_image" "aws-ubuntu-apache" {
  bucket_name    = "aws-ubuntu-apache"
  cloud_provider = "aws"
  iteration_id   = data.hcp_packer_iteration.ubuntu.ulid
  region         = var.region
}