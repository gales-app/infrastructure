resource "aws_security_group" "web" {
  name        = "web"
  description = "Allow HTTP/HTTPS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  # ingress {
  #   description = "HTTP from anywhere"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "web-sg"
    },
    var.default_tags,
  )
}

# SSH Security Group - Allow SSH from specific IPs
resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from specified IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.office_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "ssh-sg"
    },
    var.default_tags,
  )
}

resource "aws_security_group" "mongodb" {
  name        = "mongodb"
  description = "Security group for MongoDB access"
  vpc_id      = module.vpc.vpc_id
  
  # Inbound rule for MongoDB from 10.0.0.0/16
  ingress {
    description = "Allow MongoDB inbound traffic"
    from_port   = 27015
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  
  # Outbound rule for MongoDB to 192.168.0.0/16
  egress {
    description = "Allow MongoDB outbound traffic"
    from_port   = 27015
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]
  }
  
  tags = merge(
    {
      Name = "mongo-sg"
    },
    var.default_tags,
  )
}