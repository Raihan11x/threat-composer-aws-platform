resource "aws_iam_role" "github_actions_image_push" {
  name               = "${local.name_prefix}-github-actions-image-push"
  description        = "Allows GitHub Actions to push application images to ECR"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json

  max_session_duration = 3600

  tags = {
    Name = "${local.name_prefix}-github-actions-image-push"
  }
}

data "aws_iam_policy_document" "image_push_permissions" {
  statement {
    sid = "AuthenticateToEcr"

    actions = [
      "ecr:GetAuthorizationToken",
    ]

    resources = ["*"]
  }

  statement {
    sid = "PushApplicationImage"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]

    resources = [
      "arn:aws:ecr:${var.aws_region}:${data.aws_caller_identity.current.account_id}:repository/${var.project_name}",
    ]
  }
}

resource "aws_iam_role_policy" "github_actions_image_push" {
  name   = "${local.name_prefix}-image-push"
  role   = aws_iam_role.github_actions_image_push.id
  policy = data.aws_iam_policy_document.image_push_permissions.json
}
