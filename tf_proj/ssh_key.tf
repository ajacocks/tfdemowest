
resource "aws_key_pair" "ssh_key" {
  key_name   = "aschoenf_AWSRED_tf"
  public_key = var.awskey
}