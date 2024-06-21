resource "aws_s3_bucket_policy" "s3BucketPolicy" {
  bucket = var.s3BucketName
  policy = data.aws_iam_policy_document.cfIamPolicy.json
}

data "aws_iam_policy_document" "cfIamPolicy" {
  statement {
    sid = "PolicyForCloudFrontPrivateContent"
    principals {
      type        = "AWS"
      identifiers = [var.cloudFrontOAIArn]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${var.s3BucketArn}/*"
    ]
  }
}