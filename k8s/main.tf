terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://${var.proxmox_host}/api2/json"
  pm_api_token_id = "${var.K8S_TOKEN_ID}"
  pm_api_token_secret = "${var.K8S_SECRET}"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "kube-server" {
  count = 2
  name = "kube-server-0${count.index + 1}"
  target_node = "hyrule"
  vmid = "50${count.index + 1}"
  clone = "ubuntu-2310-lab-template"
  agent = 1
  os_type = "cloud-init"
  cores = 4
  sockets = 1
  cpu = "host"
  memory = 8192
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot = 0
    size = "10G"
    type = "scsi"
    storage = "local-lvm"
    iothread = 0
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
    tag = 20
  }
  
  network {
    model = "virtio"
    bridge = "vmbr50"
  }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=10.2.2.4${count.index + 1}/24,gw=10.2.2.1"
  ipconfig1 = "ip=10.50.0.4${count.index + 1}/24"
  sshkeys = <<EOF
  ${var.ssh_public_key}
  EOF
}
resource "proxmox_vm_qemu" "kube-agent" {
  count = 4
  name = "kube-agent-0${count.index + 1}"
  target_node = "hyrule"
  vmid = "51${count.index + 1}"
  clone = "ubuntu-2310-lab-template"
  agent = 1
  os_type = "cloud-init"
  cores = 4
  sockets = 1
  cpu = "host"
  memory = 4096
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot = 0
    size = "10G"
    type = "scsi"
    storage = "local-lvm"
    iothread = 0
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
    tag = 20
  }
  
  network {
    model = "virtio"
    bridge = "vmbr50"
  }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=10.2.2.5${count.index + 1}/24,gw=10.2.2.1"
  ipconfig1 = "ip=10.50.0.5${count.index + 1}/24"
  sshkeys = <<EOF
  ${var.ssh_public_key}
  EOF
}
resource "proxmox_vm_qemu" "kube-storage" {
  count = 1
  name = "kube-storage-0${count.index + 1}"
  target_node = "hyrule"
  vmid = "60${count.index + 1}"
  clone = "ubuntu-2310-lab-template"
  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 4096
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  disk {
    slot = 0
    size = "20G"
    type = "scsi"
    storage = "local-lvm"
    iothread = 0
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
    tag = 20
  }
  
  network {
    model = "virtio"
    bridge = "vmbr50"
  }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=10.2.2.6${count.index + 1}/24,gw=10.2.2.1"
  ipconfig1 = "ip=10.50.0.6${count.index + 1}/24"
  sshkeys = <<EOF
  ${var.ssh_public_key}
  EOF
}