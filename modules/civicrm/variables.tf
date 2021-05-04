variable "ssh_authorized_keys" {
  description = "Public SSH keys path to be included in the ~/.ssh/authorized_keys file for the default user on the instance. "
  default     = ""
}

variable "ssh_private_key" {
  description = "The private key path to access instance. "
  default     = ""
}

variable "vm_user" {
  description = "The SSH user to connect to the master host."
  default     = "opc"
}

variable "web_ip" {
  description = "IP of the Web Instance."
  default     = ""
}

variable "nb_of_webserver" {
    description = "Amount of Webservers to deploy"
    default = 1
}