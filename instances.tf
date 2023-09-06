
resource "aws_instance" "instances" {
  ami                         = var.image
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh_key.key_name
  count                       = var.vm_count
  vpc_security_group_ids      = [aws_security_group.tfsg.id]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  tags {
    AlwasyUp  = var.alwaysup
    Name      = var.user_name
    CreatedBy = var.created_by
    Contact   = var.my_email_address
    DeleteBy  = var.deleteby
  }
}