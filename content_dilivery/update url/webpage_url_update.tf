variable "next" {}
variable "host_ip" {}
variable "cloudfront_domain_name" {}
variable "key_path" {}
variable "default_url" {}


//updating code in /var/www/html with CF Url
resource "null_resource" "set_cf_url" {
connection {
    type = "ssh"
    user = "ec2-user"
    host = var.host_ip
    private_key = file("${var.key_path}webserver_key.pem")
}

provisioner "remote-exec" {
    inline =[ "sudo sed -i 's/${var.default_url}/${var.cloudfront_domain_name}/g' /var/www/html/index.html" ] 
}
}

output "next" {
    value = "done"
}