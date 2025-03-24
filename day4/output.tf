
output "s3_name" {
  value = aws_s3_bucket.remote_state.bucket
}


output "avaliblei_az" {
  value = data.aws_availability_zones.avaliability_zones.names
}


# output "Subnet"{
#   value = aws_instance.my_linux_vm[each.]
# }