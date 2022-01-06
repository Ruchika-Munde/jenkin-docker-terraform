provider "aws" {
	region = "ap-south-1"

}

resource "aws_instance" "EC2-Instance" {

	ami = "ami-052cef05d01020f1d"
	instance_type = "t2.micro"
	key_name = "linuxec2"
	security_groups = ["sg_linuxinstance"]
	user_data = <<EOF
		#!/bin/bash
		sudo yum update -y
		sudo yum install docker -y
		sudo systemctl start docker
		sudo curl -L https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-linux-x86_64 | sudo tee /usr/local/bin/docker-compose > /dev/null
		sudo chmod +x /usr/local/bin/docker-compose
		sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
		sudo yum install git -y
		sudo git clone https://github.com/dockersamples/example-voting-app.git
		sudo docker-compose -f /example-voting-app/docker-compose.yml up -d
		EOF


	tags = {
		"Name" = "Ec2-Instance"
	      }

}
