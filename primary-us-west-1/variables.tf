variable "rds-password" {
    description = "rds password"
    type = string
    default = "devendra"
  
}
variable "rds-username" {
    description = "rds username"
    type = string
    default = "admin"
  
}
variable "ami" {
    description = "ami"
    type = string
    default = "ami-0623300d1b7caee89"
  
}
variable "instance-type" {
    description = "instance-type"
    type = string
    default = "t2.micro"
  
}
variable "key-name" {
    description = "keyname"
    type = string
    default = "task"
  
}
variable "backupr-retention" {
    type = number
    default = "7"
  
}