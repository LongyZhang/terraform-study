
output "s3_name" {
  value = aws_s3_bucket.remote_state.bucket
}


output "avaliblei_az" {
  value = data.aws_availability_zones.avaliability_zones.names
}


output "count_index" {
  value = length(data.aws_availability_zones.avaliability_zones.names)
}
