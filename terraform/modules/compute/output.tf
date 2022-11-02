output "public-ip" {
    value = aws_instance.HostNameApp.*.public_ip
}