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
resource "aws_subnet" "Pub_Network" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.0.0/24"
    availability_zone = "eu-west-3a"

    tags = {
        Name = "Public"
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

resource "aws_route_table" "Route_Pub_Network" {
    vpc_id = "${aws_vpc.main.id}"

    route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = "${aws_internet_gateway.IG_Pub.id}"
    }

    tags = {
        Name = "Route_Pub_Network"
    }
}