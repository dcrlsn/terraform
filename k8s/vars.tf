variable "proxmox_host" {
  description = "Proxmox Host"
  default = "proxmox.dcrlsn.dev"
}
variable "template_name" {
  description = "Proxmox Template Name"
  default = "ubuntu-2310-lab-template"
}
variable "K8S_TOKEN_ID" {
  description = "Proxmox Token ID"
}
variable "K8S_SECRET" {
  description = "Proxmox API Secret"
}
variable "ssh_public_key" {
  description = "SSH Public Key"
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIES+FenVoKlLV5YsL9yH0qTKWjavr55Au/PlAYyGonSG c4r150n"
}