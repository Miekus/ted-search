resource "aws_instance" "HostNameApp" {

    count = length(var.listOfCreatedSubnetsIds)

    ami = "ami-0caef02b518350c8b"
    instance_type = "t2.micro"
    subnet_id = var.listOfCreatedSubnetsIds[count.index]
    key_name = "Mateusz_Kiszka_Key"
    security_groups =  var.frontendSecurityGroupIds
    iam_instance_profile = var.prodProfileName
    associate_public_ip_address = true


    provisioner "file" {

        source      = "./prepare-ec2.sh"
        destination = "/home/ubuntu/prepare-ec2.sh"

        connection {   
        host        = self.public_ip
        user        = "ubuntu"
        private_key = file("~/.ssh/devops_lab.pem")
        }   
    }

    provisioner "file" {

        source      = "./docker-compose-${terraform.workspace}.yml"
        destination = "/home/ubuntu/docker-compose.yml"

        connection {   
        host        = self.public_ip
        user        = "ubuntu"
        private_key = file("~/.ssh/devops_lab.pem")
        }   
    }
    provisioner "remote-exec" {
        script = "./prepare-ec2.sh" 
        connection {   
        host        = self.public_ip
        user        = "ubuntu"  
        private_key = file("~/.ssh/devops_lab.pem")
        } 
    }

    tags = { 
        Name = "Mateusz_Kiszka_T-S-EC2-t2.micro_ted-search-${count.index}-${terraform.workspace}"
        created_by = "Mateusz Kiszka"
        bootcamp = "poland1"
    }
    volume_tags = {
        Name = "Mateusz_Kiszka_T-S-EC2-t2.micro_front-end-${count.index}-${terraform.workspace}"
        created_by = "Mateusz Kiszka"
        bootcamp = "poland1"
    }
}