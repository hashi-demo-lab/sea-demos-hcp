

resource "aws_instance" "main" {
  ami                       = data.hcp_packer_image.aws-ubuntu-apache.cloud_image_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.main.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.main.id]

  tags = {
    Name = "${var.prefix}-future-instance"
  }
}

# We're using a little trick here so we can run the provisioner without
# destroying the VM. Do not do this in production.

# If you need ongoing management (Day N) of your virtual machines a tool such
# as Chef or Puppet is a better choice. These tools track the state of
# individual files and can keep them in the correct configuration.

# Here we do the following steps:
# Sync everything in files/ to the remote VM.
# Set up some environment variables for our script.
# Add execute permissions to our scripts.
# Run the deploy_app.sh script.
resource "null_resource" "configure-future-app" {
  depends_on = [aws_eip_association.main]

  triggers = {
    build_number = timestamp()
  }

  provisioner "file" {
    source      = "files/"
    destination = "/home/ubuntu/"

    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = tls_private_key.main.private_key_pem
      host        = aws_eip.main.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chown -R ${var.admin_username}:${var.admin_username} /var/www/html",
      "chmod +x *.sh",
      "cd /var/www/html",
      "sudo rm index.html",
      "sudo git clone https://github.com/CloudbrokerAz/theFutureHasLanded.git .",
      "sudo LOCATION=${var.region} PREFIX=${var.prefix} /home/${var.admin_username}/deploy_future.sh",
      "sudo certbot --agree-tos --apache --renew-by-default --register-unsafely-without-email -d ${aws_route53_record.www.fqdn}"
    ]

    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = tls_private_key.main.private_key_pem
      host        = aws_eip.main.public_ip
    }
  }
}