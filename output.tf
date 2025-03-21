output "instance_name" {
  value = aws_instance.my_linux_vm.tags.Name
}
