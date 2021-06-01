output "avs-ip" {
  value = aws_instance.avs.public_ip
}
output "avs-privkey" {
  value     = tls_private_key.avs.private_key_pem
  sensitive = true
}