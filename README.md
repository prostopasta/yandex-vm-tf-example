# yandex-vm-tf-example
## Creating VM in Yandex Cloud with Terraform 

```shell
terraform init
terraform validate
terraform plan
terraform apply
```

## Creating VM in CLI

```shell
yc compute instance create --name deploy-vm --zone ru-central1-a \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
--preemptible=true --ssh-key ~/.ssh/id_ed25519.pub
```
This will create VM with user 'yc-user' and adds SSH key from specified file to
authorized keys using cloud-config.
If your need more flexibility, use cloud-config passed in 'user-data' metadata key.
