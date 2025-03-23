output "instance_name" {
  value = aws_instance.my_linux_vm.tags.Name
}

output "s3_name" {
  value = aws_s3_bucket.remote_state.bucket
}
