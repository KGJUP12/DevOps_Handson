// Create an EKS Cluster using the Docs
resource "aws_eks_cluster" "my_custom_eks" {
  name = "my-eks-01-${random_string.bucketNameGenerator.result}"
  access_config {
    authentication_mode = "API"
  }
  role_arn = aws_iam_role.cluster.arn
  vpc_config {
    subnet_ids = module.vpc.private_subnets
  }
  depends_on = [aws_iam_role_policy_attachment.cluster_AmzonEKSClusterPolicy, ]
}

resource "aws_iam_role" "cluster" {
  name = "eks-cluster-example"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmzonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}
