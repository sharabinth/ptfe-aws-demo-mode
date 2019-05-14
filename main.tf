provider "aws" {
  # Use AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables
  region = "${var.aws_region}"
}

# Create the EC2 instance to install pTFE
resource "aws_instance" "ptfe-demo" {
  ami           = "${var.amis}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.ssh_key_name}"

  # attach the security group
  vpc_security_group_ids = ["${aws_security_group.sec_group.id}"]

  # attach the subnet
  subnet_id = "${aws_subnet.subnet.id}"

  # allocate atleast 40GB space for the pre-requisites
  root_block_device {
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
  }

  # tags to name
  tags {
    Name  = "${var.resource_prefix_name}-demo"
    owner = "${var.owner}"
  }
}

# Create elastic IP and attach it to the EC2 instance
resource "aws_eip" "ptfe-demo" {
  instance = "${aws_instance.ptfe-demo.id}"
}
