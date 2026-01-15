provider "aws" {
    region = "us-west-1"
    profile = "default"
}
provider "aws" {
  alias  = "secondary"  
  region = "us-east-2"
  profile = "default"
}