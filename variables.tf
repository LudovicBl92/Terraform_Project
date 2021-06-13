variable "security_Group_Public" {
  type = string
  default = "security_Group_Public"
}

variable "security_Group_Private" {
  type = string
  default = "security_Group_Private"
}

variable "ingress_rules_Pub" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default = [
       {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
        description = "SSH"
        },
        {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
        description = "HTTPS"
        }
    ]
}

variable "egress_rules_Pub" {
    type = list(object({
      from_port = number
      to_port = number
      protocol = string
      cidr_block = string
      description = string
    }))
    default = [
        {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
        description = "HTTPS"
        },
        {
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_block  = "0.0.0.0/0"
        description = "ICMP"
        }
    ]
}

variable "ingress_rules_NAT" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      description = string
    }))
    default = [
       {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        description = "SSH"
        },
        {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        description = "MYSQL"
        }
    ]
}
