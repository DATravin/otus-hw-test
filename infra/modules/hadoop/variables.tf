variable "yc_zone" {
  type        = string
  description = "Zone for Yandex Cloud resources"
}


variable "yc_dataproc_cluster_name" {
  type        = string
  description = "Name of the Dataproc cluster"
}

variable "yc_dataproc_version" {
  type        = string
  description = "Version of Dataproc"
}


variable "yc_data_bucket" {
  type        = string
  description = "Name of the S3 Bucket"
}


variable "service_acc_id" {
  type        = string
  description = "Service account id"
}

variable "security_group_id" {
  type        = string
  description = "Security group id"
}

variable "vpc_subnet_id" {
  type        = string
  description = "Yandex vpc subnet id"
}



# есть
variable "public_key_path" {
  type        = string
  description = "Path to the public key file"
}


variable "dataproc_master_resources" {
  type = object({
    resource_preset_id = string
    disk_type_id       = string
    disk_size          = number
  })
  default = {
    resource_preset_id = "s3-c2-m8"
    disk_type_id       = "network-ssd"
    disk_size          = 20
  }
}


variable "dataproc_data_resources" {
  type = object({
    resource_preset_id = string
    disk_type_id       = string
    disk_size          = number
  })
  default = {
    resource_preset_id = "s3-c4-m16"
    disk_type_id       = "network-hdd"
    disk_size          = 70
  }
}


variable "provider_config" {
  description = "Yandex Cloud configuration"
  type = object({
    zone      = string
    folder_id = string
    token     = string
    cloud_id  = string
  })
}
