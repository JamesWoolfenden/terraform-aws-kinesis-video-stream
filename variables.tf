variable "kms_key_id" {
  default = "alias/aws/kinesis"
}


variable "stream" {
  type = object({
    name                    = string
    data_retention_in_hours = number
    device_name             = string
    media_type              = string
  })

  default = {
    name                    = "terraform-kinesis-test"
    data_retention_in_hours = 1
    device_name             = "kinesis-video-device-name"
    media_type              = "video/h264"
  }
}
