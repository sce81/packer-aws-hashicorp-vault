source "amazon-ebs" "main" {

  ami_name        = "${var.APPNAME} ${local.timestamp}"
  ami_description = "${var.APPNAME}-${var.env}-${local.timestamp}"

  instance_type = var.instancetype
  region        = var.region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username  = "ubuntu"
  ssh_interface = "public_ip"

  associate_public_ip_address  = true


vpc_filter {
    filters = {
          "tag:Name": var.vpc_tag
    }

  }

subnet_filter {
    filters = {
          "tag:Name": var.build_subnet_tag
    }
  random = true
  }

  tags = {
        Name              = local.ami_name
        BuiltBy           = "Packer"
        author            = "sce81"
        Environment       = "dev"
        SourceAMI         = "{{ .SourceAMIName }}"
  }

}


build {
    sources = ["source.amazon-ebs.main"]

  provisioner "shell" {
    inline = ["sudo add-apt-repository -y universe", 
              "sudo apt-get update -y",
              "sudo apt install -y wget unzip",
    ]
  }

  provisioner "shell" {
    inline = [
        "echo \"Installing ${var.APPNAME}\"",
        "wget https://releases.hashicorp.com/${var.APPNAME}/${var.VERSION}/${var.APPNAME}_${var.VERSION}_linux_amd64.zip -O /tmp/${var.APPNAME}.zip",
        "unzip /tmp/${var.APPNAME}.zip -d /tmp/",
        "ls -ll /tmp",
        "sudo mv /tmp/${var.APPNAME} /usr/local/bin/"
    ]
  }
}
