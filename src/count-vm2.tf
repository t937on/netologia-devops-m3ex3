
data "yandex_compute_image" "ubuntu2" {
  family = var.vm_web_family
}

resource "yandex_compute_instance" "platform2" {
  # for_each = var.each_vm
  for_each = { for vm in var.each_vm : vm.vm_name => vm } # Преобразовать в map

  name     = each.value.vm_name
  hostname = "${var.vm_fqdn}-${each.value.vm_name}" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  zone     = var.default_zone

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu2.image_id
      size     = each.value.disk_volume
    }
  }

  platform_id = var.vm_web_platform_id
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
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

