## DATASOURCE
# Init Script Files


data "template_file" "deploy_civicrm" {
  template = file("${path.module}/scripts/deploy_civicrm.sh")
}

locals {
  deploy_civicrm   = "~/deploy_civicrm.sh"
}

resource "null_resource" "CiviCRMDeploy" {
  count    = var.nb_of_webserver
  provisioner "file" {
    content     = data.template_file.deploy_civicrm.rendered
    destination = local.deploy_civicrm

    connection  {
      type        = "ssh"
      host        = trimspace(split(",", var.web_ip)[count.index])
      agent       = false
      user        = var.vm_user
      private_key = var.ssh_private_key

    }
  }

  provisioner "remote-exec" {
    connection  {
      type        = "ssh"
      host        = trimspace(split(",", var.web_ip)[count.index])
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key

    }

    inline = [
       "chmod +x ${local.deploy_civicrm}",
       "sudo ${local.deploy_civicrm}"
    ]

  }

}