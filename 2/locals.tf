locals {
  ssh_key_file = "${file("~/.ssh/id_rsa.pub")}"
}
