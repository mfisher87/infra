packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.6"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "ssh_username" {
  type        = string
  description = "The username used during provisioning"
  default     = "root"
}

# TODO: ...filepath?
variable "ssh_private_key_file" {
  type        = string
  description = "I don't think we actually need this? I read that Packer will generate a keypair for provisioning."
}
