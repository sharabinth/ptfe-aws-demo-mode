output "ip" {
  value = "${aws_eip.ptfe-demo.public_ip}"
}

