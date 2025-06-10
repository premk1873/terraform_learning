variable "ami_id" {
  default     = "ami-05d3e0186c058c4dd"
  type        = string
  description = "ami id of the instance"
}

variable "instance_type" {
  default     = "t3.micro"
  type        = string
  description = "type of the instance"
}