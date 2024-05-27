variable "boot_command" {
    default = [
        "c<wait>",
            "set gfxpayload=keep<enter><wait>",
            "linux /casper/vmlinuz ",
                "ds=nocloud\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ ",
                "noprompt --- ",
            "<enter><wait>",
            "initrd /casper/initrd<enter><wait>",
            "boot<enter>",
        "<wait>",
    ]
    type = list(string)
}
variable "checksum_types" {
    default = [ "md5", "sha256" ]
    type = list(string)
}
variable "http_content" {
    default = null
    type = map(string)
}
variable "iso_checksum" {}
variable "iso_url" {}
variable "os_name" {}
variable "os_version" {}
variable "rootfs_url" {}
variable "skip_export" {
    default = null
    type = bool
}
variables {
    apt_mirror = "http://archive.ubuntu.com/ubuntu/"
    acpi_shutdown = true
    base_output_directory = "output"
    cpus = 2
    disk_size = 4096
    format = "ova"
    guest_additions_mode = "disable"
    guest_os_type = "Ubuntu_64"
    hard_drive_interface = "scsi"
    headless = false
    memory = 2048
    os_arch = "amd64"
    shutdown_command = "shutdown now"
    ssh_timeout = "5m"
    ssh_private_key_file = "keys/vagrant"
    ssh_public_key_file = "keys/vagrant.pub"
    ssh_username = "root"
}

locals {
    build_name = "${var.os_name}_${var.os_version}_${var.os_arch}"
    http_content = var.http_content != null ? var.http_content : {
        "/user-data": file("http/user-data"),
        "/meta-data": jsonencode({
            "v1": {
                "public_ssh_keys": split("\n", file(var.ssh_public_key_file)),
            },
        }),
    }
    output_directory = "${var.base_output_directory}/${local.build_name}"
    base_absolute_path = abspath("${local.output_directory}/${local.build_name}")
    provisioners_env = {
        "DEBIAN_FRONTEND": "noninteractive",
        "PKR_APT_MIRROR": var.apt_mirror,
        "PKR_ROOTFS_URL": var.rootfs_url,
    }
}

build {
    name = local.build_name

    source "virtualbox-iso.builder" {
        output_directory = local.output_directory
        vm_name = local.build_name
    }

    provisioner "shell" {
        env = local.provisioners_env
        scripts = fileset(path.root, "scripts/10_install/*.sh")
    }
    provisioner "shell" {
        env = local.provisioners_env
        scripts = fileset(path.root, "scripts/30_chroot/*.sh")
        remote_path = "/mnt/inside-chroot.sh"
        execute_command = "chmod +x {{ .Path }}; chroot /mnt /bin/bash -c '{{ .Vars }} /inside-chroot.sh'"
    }
    provisioner "shell" {
        env = local.provisioners_env
        scripts = fileset(path.root, "scripts/50_postinstall/*.sh")
    }
    provisioner "shell" {
        expect_disconnect = true
        inline = [ "shutdown -r now" ]
    }
    dynamic "provisioner" {
        labels = [ "shell" ]

        for_each = [ "70_custom", "90_cleanup" ]
        content {
            env = local.provisioners_env
            scripts = fileset(path.root, "scripts/${provisioner.value}/*.sh")
        }
    }

    dynamic "post-processor" {
        for_each = var.checksum_types
        labels = [ "checksum" ]
        content {
            checksum_types = [ post-processor.value ]
            output = "${local.output_directory}/${upper(post-processor.value)}SUMS"
        }
    }
}
