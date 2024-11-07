
resource "local_file" "ansible_templatefile" {
  depends_on = [yandex_compute_instance.platform1, yandex_compute_instance.platform2, yandex_compute_instance.platform3]

  content = templatefile("${path.module}/ansible.tftpl", {
    webservers = yandex_compute_instance.platform1,
    databases  = yandex_compute_instance.platform2,
    storage    = yandex_compute_instance.platform3,
  })

  filename = "${abspath(path.module)}/ansible.cfg"
}

