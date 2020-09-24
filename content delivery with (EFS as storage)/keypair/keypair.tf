variable "keypair_name" {}

//generates keys
resource "tls_private_key" "terrakey" {
    algorithm = "RSA"
}

//stores private key to a file
resource "local_file" "private_key_file" {
    depends_on = [ tls_private_key.terrakey ]

content     = tls_private_key.terrakey.private_key_pem
    filename = "${var.keypair_name}.pem"
}

//creates a key pair from the above generated key
resource "aws_key_pair" "webkey" {
    key_name = var.keypair_name
    public_key = tls_private_key.terrakey.public_key_openssh
}

output "next" {
    value = "done"
}