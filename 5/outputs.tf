# outputs.tf

/*
output "vms_info" {
  description = "VM info"
  value = merge(
    { for item in yandex_compute_instance.platform1[*] :
      item.name => {
        name = item.name
        id   = item.id
        fqdn = item.hostname
      }
    },
    { for k, v in yandex_compute_instance.platform2 :
      k => {
        name = v.name
        id   = v.id
        fqdn = v.hostname
      }
    }
  )
}
*/

output "vms_info" {
  description = "VM info"
  value = concat(
    [for item in yandex_compute_instance.platform1[*] :
      {
        fqdn = item.name
        id   = item.id
        name = item.hostname
      }
    ],
    [for k, v in yandex_compute_instance.platform2 :
      {
        fqdn = v.name
        id   = v.id
        name = v.hostname
      }
    ]
  )
}


# terraform output vms_info
