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

resource "aws_security_group" "Allow_SSH" {
    name = "SG_WEB"
    description = "SG_WEB"
    vpc_id = "${aws_vpc.main.id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["${var.Aws_My_IP}"]
    }

    tags = {
        Name = "Allow SSH from My IP"
    }
}

resource "aws_subnet" "Priv_Network" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-3b"

    tags = {
      Name = "Private"
    }
}
