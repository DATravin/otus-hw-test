variable "instance_user" {
  description = "Name of the user to create on the compute instance"
  type        = string
}

variable "instance_name" {
  description = "Name of the compute instance"
  type        = string
}

variable "service_account_id" {
  description = "ID of the service account"
  type        = string
}

variable "ubuntu_image_id" {
  description = "ID of the Ubuntu image"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private SSH key"
  type        = string
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

variable "yc_zone" {
  type        = string
  description = "Zone for Yandex Cloud resources"
}

variable "access_key" {
  description = "Access key for the bucket"
  type        = string
}

variable "secret_key" {
  description = "Secret key for the bucket"
  type        = string
}

variable "yc_data_bucket" {
  type        = string
  description = "Name of the S3 Bucket"
}

variable "vpc_subnet_id" {
  type        = string
  description = "Yandex vpc subnet id"
}
