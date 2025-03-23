terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-20250322235649" # Replace with your bucket name
    key            = "terraform.tfstate"                        # Path to store the state
    region         = "us-east-1"                                # Adjust to your AWS region
    encrypt        = true
    dynamodb_table = "terraform-state-lock-20250322235649" # Use DynamoDB for state locking
  }
}
