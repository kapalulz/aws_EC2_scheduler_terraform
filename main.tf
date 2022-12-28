#
# Autor :   Oleksandsr Kashuba  
# E-mail:   kapalkoko@gmail.com 
#

provider "aws" {
  region     = var.region
}

resource "aws_instance" "scheduler" {
  count         = var.ec2_count
  ami           = var.instance_ami
  instance_type = var.instance_type

  tags = {
    Name              = "MyServer-${count.index + 1}"
    "${var.tag_name}" = "${var.tag_value}"
  }
}

module "eventbridge" {
  source     = "terraform-aws-modules/eventbridge/aws"
  create_bus = false


  rules = {
    stop_by_time = {
      schedule_expression = "cron(${var.stop_ec2_schedule_expression})"
    }
    start_by_time = {
      schedule_expression = "cron(${var.start_ec2_schedule_expression})"
    }
  }

  targets = {
    stop_by_time = [
      {
        name = "lambda-stop"
        arn  = data.aws_lambda_function.stop_lambda_function.arn
      }
    ]
    start_by_time = [
      {
        name = "lambda-start"
        arn  = data.aws_lambda_function.start_lambda_function.arn
      }
    ]
  }
}
