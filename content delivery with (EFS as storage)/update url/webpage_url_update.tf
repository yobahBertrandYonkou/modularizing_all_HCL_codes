variable "next" {}
variable "host_ip" {}
variable "cloudfront_domain_name" {}
variable "key_path" {}
variable "default_url" {}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "timeout 120"
  }
}
//updating code in /var/www/html with CF Url
resource "null_resource" "set_cf_url" {
    depends_on = [null_resource.delay]
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