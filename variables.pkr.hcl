variable "name"                 {
    type            = string
    default         = "Wordpress"
    description     = "name of compontent being built"
    sensitive       = false
}
variable "VERSION"         {
    type            = string
    default         = "1.9.0"
    description     = "Version of App deployed"
    sensitive       = false
}

variable "instancetype"         {
    type            = string
    default         = "t3.large"
    description     = "size of provisioner"
    sensitive       = false
}
variable "region"               {
    type            = string
    default         = "eu-west-1"
    description     = "region to build in"
    sensitive       = false
}
variable "env"               {
    type            = string
    default         = "dev"
    description     = "environment name"
    sensitive       = false
}
variable "jenkins_build_id" {
    default         = "0000"
    description     = "Jenkins Build Number"
    sensitive       = false
}

variable "APPNAME" {
    default         = "vault"
    description     = "Hashicorp App to install"
    sensitive       = false
}