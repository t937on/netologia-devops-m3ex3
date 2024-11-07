
resource "yandex_compute_disk" "vm_disk" {
  count = var.vm_disk_cnt
  name  = "${var.vm_disk_rsc.name}-${count.index + 1}"
  size  = var.vm_disk_rsc.size
  type  = var.vm_disk_rsc.type
  zone  = var.default_zone
}

data "yandex_compute_image" "ubuntu3" {
  family = var.vm_web_family
}

resource "yandex_compute_instance" "platform3" {
  name     = var.vm3_name
  hostname = "netology-develop-platform-vm-${var.vm3_name}" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  zone     = var.default_zone

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu3.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.vm_disk
    content {
      disk_id     = secondary_disk.value.id
      auto_delete = true # Удалить диск при удалении ВМ
    }
  }

  platform_id = var.vm3_platform_id
  resources {
    cores         = var.vm3_rsc.cores
    memory        = var.vm3_rsc.memory
    core_fraction = var.vm3_rsc.core_fraction
  }

  scheduling_policy {
    preemptible = var.vm3_preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm3_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.vm3_meta["serial-port-enable"]
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


