variable "ingress_rules" {
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
        },
    ]
}

variable "egress_rules" {
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
        }
    ]
}