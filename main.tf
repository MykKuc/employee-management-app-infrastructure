terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.48.0"
    }
  }
}

provider "aws" {
    region = "eu-west-2"
}

## Define the Route 53 Hosted Zone. 
resource "aws_route53_zone" "employeemanagement_com_hosted_zone" {
  name = "employeemanagementapp.com"
}

## Define the CloudFront distributions.

## Definition of TLS/SSL certificate.

## Define the S3 Bucket.
resource "aws_s3_bucket" "employee_management_app_angular_build_bucket" {
  
}

# There is another Terraform resource for Website Hosting.

## Define the security groups for EC2 Instances.

## Define the EC2 Instances.
resource "aws_instance" "employee_app_instances" {
    ami = "ami-06ce824c157700cd2"
    instance_type = "t3.nano"
    count = 2
  
}

## Defined the security group for Application Load Balancer.
resource "aws_security_group" "application_load_balancer_sg" {
    name = "main-load-balancer-sg"
    description = "Security Group for the application load balancer of employee management app."

  
}


## Define the Application Load Balancer, listener and Target group.
resource "aws_lb" "employee_management_app_lb" {
    name = "main-load-balancer"

    load_balancer_type = "application"
  
}

resource "aws_lb_target_group" "main_lb_target_group" {
  
}




## Define the Amazon RDS MySQL datbase and security group for it.


resource "aws_db_instance" "employee_management_database" {
    db_name = "Employee-management-database"
    instance_class = "db.t3.micro"
    allocated_storage = 10
    engine = "mysql"
    engine_version = "8.0"
    skip_final_snapshot = true
    username = "administrator"
  
}