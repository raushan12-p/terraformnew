variable "ami" {
  description = "passing value to main.tf"
  type = string
  default = ""
}
variable "instance_type" {
  default = ""
  type = string
}
variable "key_name" {
  type = string
  default = ""
}