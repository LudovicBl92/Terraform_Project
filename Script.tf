resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "Project_Web"
    }
}

resource "aws_internet_gateway" "IG_Pub" {
    vpc_id = "${aws_vpc.main.id}"

    tags = {
        Name = "Ig_Pub"
    }
}

resource "aws_route_table" "Internet_Gateway" {
    vpc_id = "${aws_vpc.main.id}"

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IG_Pub.id}"
    }

    tags = {
        Name = "Internet_Gateway"
    }
}

resource "aws_subnet" "Pub_Network" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.0.0/24"
    availability_zone = "eu-west-3a"

    tags = {
        Name = "Public"
    }
}

resource "aws_route_table_association" "Internet_traffic" {
    subnet_id = "${aws_subnet.Pub_Network.id}"
    route_table_id = "${aws_route_table.Internet_Gateway.id}"
}

resource "aws_security_group" "SG_WEB" {
    name = "SG_WEB"
    description = "SG_WEB"
    vpc_id = "${aws_vpc.main.id}"

    tags = {
        Name = "SG_WEB"
    }
}
resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.ingress_rules)

  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = aws_security_group.SG_WEB.id
}
resource "aws_subnet" "Priv_Network" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-3b"

    tags = {
      Name = "Private"
    }
}
