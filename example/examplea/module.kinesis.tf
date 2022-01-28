module "kinesis" {
  source     = "../../"
  kms_key_id = aws_kms_key.example.arn
}


resource "aws_kms_key" "example" {
  enable_key_rotation = true
}
