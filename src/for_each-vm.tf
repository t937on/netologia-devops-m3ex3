variable "each_vm" {
  type = list(object({
    vm_name       = string,
    cpu           = number,
    ram           = number,
    disk_volume   = number,
    core_fraction = number
  }))
  default = [
    {
      vm_name       = "main"
      cpu           = 2
      ram           = 1
      disk_volume   = 5
      core_fraction = 5
    },
    {
      vm_name       = "replica"
      cpu           = 4
      ram           = 2
      disk_volume   = 10
      core_fraction = 5
    }
  ]
}
