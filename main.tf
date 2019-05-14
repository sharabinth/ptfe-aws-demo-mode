provider "aws" {
  # Use AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables
  region     = "${var.aws_region}"
  
}

# Setup Network services such as VPC and also create a Security Group to enable SSH into the instance
# 

resource "aws_instance" "ptfe-demo" {
  ami = "${var.amis}"
  instance_type = "${var.instance_type}"
  key_name = "${var.ssh_key_name}"

  # allocate atleast 40GB space for the pre-requisites
  root_block_device {
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
  }

  # tags to name
  tags {
    Name  = "${var.instance_name}"
    owner = "${var.owner}"
  }
}

resource "aws_eip" "ptfe-demo" {
  instance = "${aws_instance.ptfe-demo.id}"
}
