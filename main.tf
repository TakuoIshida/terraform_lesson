provider "aws" {
  region = "ap-northeast-1"
}

#5章 権限管理
# data "aws_iam_policy_document" "allow_describe_regions" {
#   statement {
#     effect    = "Allow"
#     actions   = ["ec2:DescribeRegions"]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_policy" "example" {
#   name   = "example"
#   policy = data.aws_iam_policy_document.allow_describe_regions.json
# }

# module "describe_region_for_ec2" {
#   source     = "./iam_role/"
#   name       = "describe-region-for-ec2"
#   identifier = "ec2.amazonaws.com"
#   policy     = data.aws_iam_policy_document.allow_describe_regions.json
# }



#6章 ストレージ
# S3 のprivate bucket
# resource "aws_s3_bucket" "my_private_bucket" {
#   bucket = "my-terraform-lesson" //globalに一意な名前
#   acl    = "private"
#   # policy = file("./bucket_policy.json") //json形式でバケットのポリシーを記述し、file()でimportする
#   versioning {
#     enabled = true
#   }

#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256" //  sse_algorithm     = "aws:kms"
#       }
#     }
#   }
# }

# S3 のpublic bucket
# resource "aws_s3_bucket" "my_public_bucket" {
#   bucket = "my-terraform-lesson-pub"
#   acl    = "public-read"
#   cors_rule {
#     allowed_origins = ["https://localhost:3000"]
#     allowed_methods = ["GET"]
#     allowed_headers = ["*"]
#     max_age_seconds = 3000
#   }
#   logging {
#     target_bucket = aws_s3_bucket.log_bucket.id
#     target_prefix = "log/"
#   }
# }

# S3 の Log bucket
# resource "aws_s3_bucket" "logging_bucket" {
#   bucket = "my-terraform-lesson-logging"
#   # 中が空でなくても破棄できるようにする場合
#   # force_destroy = true 
#   lifecycle_rule {
#     enabled = true
#     expiration {
#       days = 180
#     }
#   }

# }

# resource "aws_s3_bucket_policy" "alb_log" {
#   bucket = aws_s3_bucket.logging_bucket.id
#   policy = data.aws_iam_policy_document.alb_logging_policy.json
# }

# data "aws_iam_policy_document" "alb_logging_policy" {
#   statement {
#     effect    = "Allow"
#     actions   = ["S3:PutObject"]
#     resources = ["arn:aws:s3:::${aws_s3_bucket.logging_bucket.id}/*"]
#     principals {
#       type        = "AWS"
#       identifiers = ["988850671127"]
#     }
#   }
# }
