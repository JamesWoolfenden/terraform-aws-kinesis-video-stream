provider "aws" {
  region = "eu-west-2"
default_tags {
  tags={
    module="terraform-aws-kinesis-video-stream"
    createdby="terraform"
  }
}
}
