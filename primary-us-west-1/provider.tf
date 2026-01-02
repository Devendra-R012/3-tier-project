provider "aws" {  
  region = "us-west-1"
  }
provider "aws" {
  alias  = "secondary"  
  region = "us-east-2"
}