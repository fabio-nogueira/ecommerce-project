## AWS account level config: region
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

## Key to allow connection to our EC2 instance
variable "key_name" {
  description = "EC2-fabio-airflow-sandbox"
  type        = string
  default     = "sde-key"
}

## EC2 instance type
variable "instance_type" {
  description = "Instance type for EMR and EC2"
  type        = string
  default     = "m4.xlarge"
}

## Alert email receiver
variable "alert_email_id" {
  description = "Email id to send alerts to "
  type        = string
  default     = "fabio.nogueira@bestseller.com"
}

## Your repository url
variable "repo_url" {
  description = "Repository url to clone into production machine"
  type        = string
  default     = "https://github.com/fabio-nogueira/airflow-sandbox.git"
}
