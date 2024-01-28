# Docs: https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox/latest/components/builder/iso
# NOTE: Periods not allowed (?) in source names, because they are referenced
# with period as delimiter in build section.
source "proxmox-iso" "ubuntu-22-04" {
  proxmox_url               = "${var.proxmox_api_url}"
  username                  = "${var.proxmox_api_token_id}"
  token                     = "${var.proxmox_api_token_secret}"
  # NOTE: Self-signed / auto-generated PVE certs will fail (unknown authority)
  #       without this option:
  # TODO: ACME certs
  insecure_skip_tls_verify  = true

  node                      = "mrpl-vhost02"
  vm_id                     = "10001"
  # NOTE: Periods not allowed in VM names for DNS reasons
  vm_name                   = "template-ubuntu-22-04"
  template_description      = "An Ubuntu Jammy (22.04) VM with users and many dependencies pre-installed"

  iso_url                   = "https://releases.ubuntu.com/22.04.3/ubuntu-22.04.3-live-server-amd64.iso"
  iso_checksum              = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
  iso_storage_pool          = "iso"
  unmount_iso               = true

  qemu_agent                = true

  scsi_controller           = "virtio-scsi-pci"

  cores                     = "2"
  sockets                   = "1"
  memory                    = "4096"

  cloud_init                = true
  # NOTE: By default, the storage pool of the boot disk is used, but that's not working
  #       "cloud_init is set to true, but cloud_init_storage_pool is empty and could not be set automatically."
  cloud_init_storage_pool   = "local"

  vga {
    # NOTE: "std" is the same as "Default" in the proxmox GUI. Works fine. Why
    # might we want to use "virtio"?
    type                    = "std"
  }

  disks {
    disk_size               = "20G"
    format                  = "qcow2"
    storage_pool            = "local"
    # TODO: Why might we want to use "virtio" here?
    type                    = "scsi"
  }

  network_adapters {
    model                   = "virtio"
    bridge                  = "vmbr0"
    # MAC address is deterministic based on VM ID and NIC ID:
    mac_address             = "repeatable"
    firewall                = "true"
  }

  boot_command = [
    "<esc><wait>",
    "e<wait>",
    "<down><down><down><end>",
    "<bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  
  # Force CDROM boot:
  boot                      = "c"
  boot_wait                 = "10s"
  communicator              = "ssh"

  http_directory            = "./http"

  # TODO: Can't this just be "root"? What about a default var value?
  # TODO: What is the minimal set we actually need??
  # TODO: Create a temp provisioning user in addition to the user(s) that will
  #       be permanent.
  ssh_username              = "${var.ssh_username}"
  ssh_password              = "${var.ssh_password}"
  ssh_private_key_file      = "${var.ssh_private_key_file}"

  ssh_handshake_attempts    = 15
  ssh_pty                   = true
  # Time to wait for SSH to be ready:
  # NOTE: The whole OS install process must complete, so we need longer than
  #       the default 10m.
  ssh_timeout               = "20m"
}

build {

  # Used for logging purposes:
  name    = "ubuntu-22-04"

  sources = [
      "source.proxmox-iso.ubuntu-22-04"
  ]

  # Wait for cloud-init:
  provisioner "shell" {
    inline = ["cloud-init status --wait"]
  }

  # Configure the OS for Proxmox cloud-init integration
  provisioner "shell" {
    execute_command = "echo -e '<user>' | sudo -S -E bash '{{ .Path }}'"
    inline = [
      "sudo rm /etc/ssh/ssh_host_*",
      "sudo truncate -s 0 /etc/machine-id",
      "sudo apt -y autoremove --purge",
      "sudo apt -y clean",
      "sudo apt -y autoclean",
      "sudo cloud-init clean",
      "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
      "sudo rm -f /etc/netplan/00-installer-config.yaml",
      "sudo sync",
    ]
  }

  # Configure cloud-init data sources (described in docs as a boot-time optimization):
  # NOTE: The documentation for file provisioner
  #       (https://developer.hashicorp.com/packer/docs/provisioners/file) says
  #       this is the only way to get files to root-owned locations.
  provisioner "file" {
    source      = "./99-pve.cfg"
    destination = "/tmp/99-pve.cfg"
  }
  provisioner "shell" {
    execute_command = "echo -e '<user>' | sudo -S -E bash '{{ .Path }}'"
    inline = [
      "sudo mv /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/.",
    ]
  }

  # Install docker per docs: https://docs.docker.com/engine/install/ubuntu/
  # TODO: Try NEEDRESTART_MODE to get past last step?? https://askubuntu.com/questions/1367139/apt-get-upgrade-auto-restart-services
  # provisioner "shell" {
  #     inline = [
  #         "sudo apt-get install -y ca-certificates curl gnupg lsb-release",
  #         "sudo install -m 0755 -d /etc/apt/keyrings",
  #         "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
  #         "sudo chmod a+r /etc/apt/keyrings/docker.gpg",
  #         "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
  #         "sudo apt-get -y update",
  #         "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
  #     ]
  # }

  # # Clean up
  # provisioner "shell" {
  #   inline = [
  #     "sudo userdel -r ${var.ssh_username}",
  #     "sudo groupdel ${var.ssh_username}",
  #     "sudo apt -y autoremove --purge",
  #     "sudo apt -y clean",
  #     "sudo apt -y autoclean",
  #   ]
  # }
}
