
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

resource "yandex_compute_instance" "platform1" {
  depends_on = [yandex_compute_instance.platform2]

  count    = var.vm_web_cnt
  name     = "${var.vm_web_name}-${count.index + 1}"
  hostname = "${var.vm_web_fqdn}-${count.index}" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  zone     = var.default_zone

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vm_web_rsc.cores
    memory        = var.vm_web_rsc.memory
    core_fraction = var.vm_web_rsc.core_fraction
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_web_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.vm_web_meta["serial-port-enable"]
    ssh-keys           = local.ssh_key_file
    user-data          = <<-EOF
        #cloud-config
        users:
          - name: ${var.vm_web_meta["user"]}
            ssh-authorized-keys:
              - ${local.ssh_key_file}
            sudo: ['ALL=(ALL) NOPASSWD:ALL']
            groups: [sudo]
        EOF
  }

  allow_stopping_for_update = true
}

