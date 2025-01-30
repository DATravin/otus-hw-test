


# Compute ресурсы
resource "yandex_compute_disk" "boot_disk" {
  name     = "boot-disk"
  zone     = var.yc_zone # есть
  image_id = var.ubuntu_image_id # есть
  size     = 30
}

resource "yandex_compute_instance" "proxy" {
  name                      = var.instance_name # есть
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = var.yc_zone # есть
  service_account_id        = var.service_account_id #yandex_iam_service_account.sa.id есть
  # size                      = var.proxy_size

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}" # есть
    user-data = templatefile("${path.root}/scripts/user_data.sh", {
      token                       = var.provider_config.token # есть
      cloud_id                    = var.provider_config.cloud_id # есть
      folder_id                   = var.provider_config.folder_id # есть
      private_key                 = file(var.private_key_path) # есть
      access_key                  = var.access_key # есть
      secret_key                  = var.secret_key # есть
      s3_bucket                   = var.yc_data_bucket # есть
      upload_data_to_hdfs_content = file("${path.root}/scripts/upload_data_to_hdfs.sh")
      upload_data_from_hdfs_content = file("${path.root}/scripts/upload_data_from_hdfs.sh")
    })
  }

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores  = 2
    memory = 16
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot_disk.id
  }

  network_interface {
    subnet_id = var.vpc_subnet_id # есть
    nat       = true
  }

  metadata_options {
    gce_http_endpoint = 1
    gce_http_token    = 1
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.network_interface[0].nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cloud-init status --wait",
      "echo 'User-data script execution log:' | sudo tee /var/log/user_data_execution.log",
      "sudo cat /var/log/cloud-init-output.log | sudo tee -a /var/log/user_data_execution.log",
    ]
  }
}
