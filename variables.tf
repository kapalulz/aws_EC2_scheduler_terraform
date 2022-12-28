variable "region" {
  type        = string
  description = "Region Name"
  //default     = "us-east-1"
}

variable "instance_ami" {
  type        = string
  description = "Instance AMI"
  //default     = "ami-0574da719dca65348"
}
variable "instance_type" {
  type        = string
  description = "Instance Type"
  default     = "t2.micro"
}

variable "ec2_count" {
  type        = string
  description = "\n How many ec2_instances do you want to create? : "
  default     = 3
}

//start time
variable "start_ec2_schedule_expression" {
  description = "\n Write 'cron' expression that specifies turn ON time. (UTC) \n • Check: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html \n Example: 55 13 ? * MON-FRI * "
  //default     = "55 02 ? * MON-FRI *"
}

//stop time
variable "stop_ec2_schedule_expression" {
  description = "\n Write 'cron' expression that specifies turn OFF time. (UTC) \n • Check: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html \n Example: 55 13 ? * MON-FRI * "
  //default     = "53 02 ? * MON-FRI *"
}

variable "tag_value" {
  type        = string
  description = "\n The value of tag, by this value 'scheduler' trigger works"
  default     = "enable"
}

variable "tag_name" {
  type        = string
  description = "\n The key of ec2 tag, by this key 'scheduler' trigger works"
  default     = "Scheduler"
}

variable "function_names" {
  type = list(string)
  default = [
    "Stop_by_tag",
    "Start_by_tag"
  ]
}

variable "lambda_function" {
  type = map(string)
  default = {
    "Stop_by_tag"  = "stop_function.zip",
    "Start_by_tag" = "start_function.zip"
  }
}

//Path to function
variable "archive_to_zip" {
  type = map(string)
  default = {
    "lambda_scripts/stop_function/lambda_function.py"  = "stop_function.zip",
    "lambda_scripts/start_function/lambda_function.py" = "start_function.zip"
  }
}
