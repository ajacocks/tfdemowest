

output "dbserver" {
  value = "dbserver-tf => ${aws_instance.dbserver.id}:${aws_instance.dbserver.public_ip}"
}

output "webserver" {
  value = "webserver-tf => ${aws_instance.webserver.id}:${aws_instance.webserver.public_ip}"
}