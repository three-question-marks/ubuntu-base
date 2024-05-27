packer {
    required_plugins {
        virtualbox = {
            version = ">= 0.0.1"
            source = "github.com/hashicorp/virtualbox"
        }
    }
}

variable "vboxmanage_post" {
    default = null
    type = list(list(string))
}

locals {
    vboxmanage_post = var.vboxmanage_post != null ? var.vboxmanage_post : [
        [ "modifymedium", "--compact", "${local.base_absolute_path}.vdi" ],
        [
            "clonemedium",
                "--format=QCOW",
                "${local.base_absolute_path}.vdi",
                "${local.base_absolute_path}.qcow2",
        ],
        [ "closemedium", "${local.base_absolute_path}.qcow2" ],
        [
            "clonemedium",
                "--format=VMDK",
                "${local.base_absolute_path}.vdi",
                "${local.base_absolute_path}.vmdk",
        ],
        [ "closemedium", "${local.base_absolute_path}.vmdk" ],
    ]
}

source "virtualbox-iso" "builder" {
    acpi_shutdown           = var.acpi_shutdown
    boot_command            = var.boot_command
    cpus                    = var.cpus
    disk_size               = var.disk_size
    format                  = var.format
    guest_additions_mode    = var.guest_additions_mode
    guest_os_type           = var.guest_os_type
    hard_drive_interface    = var.hard_drive_interface
    headless                = var.headless
    http_content            = local.http_content
    iso_checksum            = var.iso_checksum
    iso_url                 = var.iso_url
    memory                  = var.memory
    shutdown_command        = var.shutdown_command
    skip_export             = local.skip_export
    ssh_private_key_file    = var.ssh_private_key_file
    ssh_timeout             = var.ssh_timeout
    ssh_username            = var.ssh_username
    vboxmanage_post         = local.vboxmanage_post
}
