

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "20.12.0"

#   cluster_name    = local.cluster_name
#   cluster_version = "1.30"

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.4"

  cluster_name    = local.cluster_name
  cluster_version = "1.30"
  # cluster_version = "1.24"  ORIG
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # NEW - ADDED - JP
  cluster_endpoint_public_access = true
  enable_irsa                    = true


  # EKS Managed Node Group(s) 
  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
    key_name = "jp-2024-acg"
  }


  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"
      # key_name   = "tf-key"
      # key_name   = "jp-2024"
      # key_name   = "var.key_name"

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }

    two = {
      name = "node-group-2"

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"
      # key_name   = "tf-key"
      # key_name   = "jp-2024"
      # key_name   = "var.key_name"

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}

###### PLACE AFTER 'NODE_GROUPS' CODEBLOCK #######

# Create & attach SSH Key Pair
resource "aws_key_pair" "ssh-key" {
  # key_name   = "tf-key"
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}

# RSA key of size 4096 bits
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${var.key_name}.pem"
  # filename = "~/.ssh/tfkey"
  # filename = "${path.module}/foo.bar"

  # Set permissions on new SSH Private key
  provisioner "local-exec" {
    command = "echo 'Your new KeyPair named: ${var.key_name}.pem has been created and attached to all instances & the public key is saved in this repo. Cheers!' > New-KeyPair_INFO.txt"
  }

  provisioner "local-exec" {
    command = "chmod 400 ${var.key_name}.pem"

    # command = "chmod 400 tf-key.pem"
  }
}
