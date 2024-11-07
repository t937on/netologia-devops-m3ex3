###cloud vars
/*
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}
*/

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###1

###2
variable "vm_web_family" {
  description = "yandex compute image family"
  type        = string
  default     = "ubuntu-2004-lts" #ubuntu - пользователь по умолчанию
}


variable "vm_web_cnt" {
  description = "yandex_compute_instance count"
  type        = number
  default     = 2
}

variable "vm_web_rsc" {
  description = "yandex_compute_instance resources"
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
}

variable "vm_web_platform_id" {
  description = "yandex compute instance platform id"
  type        = string
  default     = "standard-v2"
}

variable "vm_web_preemptible" {
  description = "yandex compute instance scheduling policy preemptible"
  type        = bool
  default     = true
}

variable "vm_web_nat" {
  description = "yandex compute instance network interface nat"
  type        = bool
  default     = true
}

variable "vm_web_meta" {
  description = "Метаданные ВМ"
  type = object({
    serial-port-enable = number
    user               = string
  })
  default = {
    serial-port-enable = 1
    user               = "supuser"
  }
}


###3
variable "vm_disk_cnt" {
  description = "yandex_compute_disk count"
  type        = number
  default     = 3
}

variable "vm_disk_rsc" {
  description = "yandex_compute_disk resources"
  type = object({
    name = string
    size = number
    type = string
  })
  default = {
    name = "disk-web"
    size = 1 # 1ГБ
    type = "network-hdd"
  }
}


variable "vm3_name" {
  description = "yandex_compute_instance name"
  type        = string
  default     = "storage"
}

variable "vm3_platform_id" {
  description = "yandex compute instance platform id"
  type        = string
  default     = "standard-v2"
}

variable "vm3_rsc" {
  description = "yandex_compute_instance resources"
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
}

variable "vm3_preemptible" {
  description = "yandex compute instance scheduling policy preemptible"
  type        = bool
  default     = true
}

variable "vm3_nat" {
  description = "yandex compute instance network interface nat"
  type        = bool
  default     = true
}

variable "vm3_meta" {
  description = "Метаданные ВМ"
  type = object({
    serial-port-enable = number
    user               = string
  })
  default = {
    serial-port-enable = 1
    user               = "supuser"
  }
}


