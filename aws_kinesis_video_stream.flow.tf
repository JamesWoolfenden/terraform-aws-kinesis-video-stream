# tfsec:ignore:AWS024
resource "aws_kinesis_video_stream" "flow" {
  name             = var.stream["name"]
  
  data_retention_in_hours = var.stream["data_retention_in_hours"]
  device_name             = var.stream["device_name"]
  media_type              = var.stream["media_type"]

  kms_key_id      = var.kms_key_id
}
