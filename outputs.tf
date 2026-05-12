output "car_showroom_url" {
  value       = "http://${aws_instance.digistack_instance.public_ip}"
  description = "The public URL of the car showroom"
}
