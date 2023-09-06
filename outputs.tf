output "ec2_map" {
  value = { for i in aws_instance.ec2instance : i.tags.Name => "${i.id}:${i.public_ip}" }
}