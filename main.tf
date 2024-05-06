terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.87.0"
    }
  }
}

#provider "yandex" {
#  zone      = "ru-central1-a"
#}
# 
# Тут мы эскейпим текст чтобы не получить ошибки bash с определением переменных в конце файла

resource "yandex_compute_instance" "vm" {
    name        = "vm-tf-std3"
    platform_id = "standard-v3"
    zone        = "ru-central1-a"

    # Конфигурация ресурсов:
    # количество процессоров и оперативной памяти
    resources {
        cores  = 2
        memory = 2
    }

    # Загрузочный диск:
    # здесь указывается образ операционной системы
    # для новой виртуальной машины
    boot_disk {
        initialize_params {
            image_id = "fd80bm0rh4rkepi5ksdi"
        }
    }

    # Сетевой интерфейс:
    # нужно указать идентификатор подсети, к которой будет подключена ВМ
    network_interface {
        subnet_id = "e9bd0gre8m6bpdsfslce"
        nat       = false
    }

    # Метаданные машины:
    # здесь можно указать скрипт, который запустится при создании ВМ
    # или список SSH-ключей для доступа на ВМ
    metadata = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    }
}

output "ip_address" {
    value = yandex_compute_instance.vm.network_interface.0.ip_address
}
