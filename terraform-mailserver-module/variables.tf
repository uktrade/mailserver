variable "environment" {
  type = string
}

// --- mail server variables

variable "mailserver_registry" {
  type = string
}

variable "email_domain" {
  type = string
}

variable "certbot_email" {
  type = string
}

variable "mail_username" {
  type = string
}

variable "mail_password" {
  type = string
}

// --- vpc/cluster variables

variable "security_group_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

variable "vpc_cidr" {
  type = string
}
