terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.48.0"
    }

    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
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

resource "aws_route53_record" "name" {
  
}

resource "aws_route53_record" "name" {
  
}

resource "aws_route53_record" "name" {
  
}

resource "aws_route53_record" "name" {
  
}

resource "aws_route53_record" "name" {
  
}

## Define the CloudFront distributions.

resource "aws_cloudfront_distribution" "employeemanagementapp_com_distribution" {
  
}

resource "aws_cloudfront_distribution" "www_employeemanagementapp_com_distribution" {

  
}


## Definition of TLS/SSL certificate.
resource "aws_acm_certificate" "name" {
    
  
}


## Define the S3 Bucket and static website hosting.
## ++
resource "aws_s3_bucket_policy" "s3_employeemanagementapp_com_policy" {
  bucket = aws_s3_bucket.employeemanagementapp_com_bucket.id
  policy = <<EOF
        {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::employeemanagementapp.com/*"
        }
    ]
}
  EOF
}
## ++
resource "aws_s3_bucket_policy" "s3_www_employeemanagementapp_com_policy" {
    bucket = aws_s3_bucket.www_employeemanagementapp_com_bucket.id
    policy = <<EOF
        {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::www.employeemanagementapp.com/*"
        }
    ]
}
EOF
}
#++
resource "aws_s3_bucket" "employeemanagementapp_com_bucket" {
  bucket = "employeemanagementapp.com"
}
##++
resource "aws_s3_bucket" "www_employeemanagementapp_com_bucket" {
  bucket = "www.employeemanagementapp.com"
}

##++
resource "aws_s3_bucket_website_configuration" "employeemanagementapp_com_bucket_website" {
  bucket = aws_s3_bucket.employeemanagementapp_com_bucket.bucket
  index_document {
    suffix = "index.html"
  }
}

## ++
resource "aws_s3_bucket_website_configuration" "www_employeemanagementapp_com_bucket_website" {
  bucket = aws_s3_bucket.www_employeemanagementapp_com_bucket.bucket

  redirect_all_requests_to {
    host_name = aws_s3_bucket.employeemanagementapp_com_bucket.bucket
    protocol = "https"
  }
}

# There is another Terraform resource for Website Hosting.


## Define the EC2 Instances and key pairs to allow to SSH and Security Groups.
## ++
resource "tls_private_key" "main_private_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}
#++
resource "aws_key_pair" "ec2_key_pair_main" {
    key_name = "main-key-pair"
    public_key = tls_private_key.main_private_key.public_key_openssh
}

resource "aws_security_group" "main_instances_sg" {
    name = "main-java-app-sg"
    description = "Security Group for AWS Instances that run my Java Spring Boot application."

    ingress {

    }

    egress {

    }

    tags {
        Name = "main-java-app-instances-sg"
    }
}

resource "aws_instance" "employee_app_instances" {
    ami = "ami-06ce824c157700cd2"
    instance_type = "t3.nano"
    count = 2
    key_name = aws_key_pair.ec2_key_pair_main.key_name

    root_block_device {
      delete_on_termination = true
      volume_type = "gp2"
      volume_size = "10"
    }
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
## I need to configure incoming traffic from EC2 Instances.
resource "aws_security_group" "main_db_sg" {
    name = "main-sql-db-sg"
    description = "Security Group for main database of the Employee Management Application."

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "TCP"

    }
    
    egress{

        from_port = 0
        to_port = 0


    }
}

resource "aws_db_instance" "employee_management_database" {
    db_name = "Employee-management-database"
    instance_class = "db.t3.micro"
    allocated_storage = 10
    engine = "mysql"
    engine_version = "8.0"
    skip_final_snapshot = true
    username = "administrator"
  
}