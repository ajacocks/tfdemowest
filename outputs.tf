output "ec2_map" {
  value = { for i in aws_instance.instances : i.tags.Name => "${i.id}:${i.public_ip}" }
}
