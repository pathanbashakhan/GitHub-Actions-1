# VPC and Networking
resource "aws_vpc" "digistack_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "digistack-vpc" }
}

resource "aws_subnet" "digistack_vpc_subnet" {
  vpc_id                  = aws_vpc.digistack_vpc.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags = { Name = "digistack-public-subnet" }
}

resource "aws_internet_gateway" "digistack_igw" {
  vpc_id = aws_vpc.digistack_vpc.id
  tags   = { Name = "digistack-igw" }
}


resource "aws_route_table" "digistack_rt" {
  vpc_id = aws_vpc.digistack_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.digistack_igw.id
  }
  tags = { Name = "digistack-public-rt" }
}

resource "aws_route_table_association" "digistack_rta" {
  subnet_id      = aws_subnet.digistack_vpc_subnet.id
  route_table_id = aws_route_table.digistack_rt.id
}

# Security Group
resource "aws_security_group" "digistack_sg" {
  name   = "digistack-sg"
  vpc_id = aws_vpc.digistack_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "digistack_instance" {
  ami                    = "ami-01c68ee746ed2863d"
  instance_type          = "t3.micro"
  key_name               = "Terraform-key"
  subnet_id              = aws_subnet.digistack_vpc_subnet.id
  vpc_security_group_ids = [aws_security_group.digistack_sg.id]

  user_data = templatefile("${path.module}/startupscript.sh", {
    featured_car = "Mahindra Thar Roxx"
  })

  tags = { Name = "digistack-instance" }
}

# Provisioner (Self-referencing the instance IP)
resource "null_resource" "ec2_ope" {
  depends_on = [aws_instance.digistack_instance]

  connection {
    host        = aws_instance.digistack_instance.public_ip
    user        = "ec2-user"
    type        = "ssh"
    private_key = file("${path.module}/key/Terraform-key.pem")
  }

  provisioner "file" {
    source      = "${path.module}/key/Terraform-key.pem"
    destination = "/tmp/Terraform-key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /tmp/Terraform-key.pem",
      "mkdir -p /tmp/myapp",
      "touch /tmp/myapp/app.log",
      "echo 'Hello from digistack sys to test sys created file' > /tmp/myapp/app.log"
    ]
  }
}
