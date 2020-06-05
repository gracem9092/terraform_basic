resource "aws_instance" "web1" {
  ami = "ami-09d95fab7fff3776c"
  instance_type = "t3.micro"
}
