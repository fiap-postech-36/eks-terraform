resource "aws_iam_role" "test" {
  name               = "test-role"
  assume_role_policy = "${file("assume-role-policy.json")}"
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy      = "${file("policy-s3-bucket.json")}"
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = ["${aws_iam_role.test.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_instance_profile" "test_profile" {
  name  = "test_profile"
  roles = ["${aws_iam_role.test.name}"]
}

resource "aws_instance" "main" {
  ami                    = "ami-9a562df2"
  instance_type          = "t2.small"
  iam_instance_profile   = "${aws_iam_instance_profile.test_profile.name}"
  vpc_security_group_ids = ["${aws_security_group.main.id}"]
}

resource "aws_security_group" "main" {
  name        = "ssh"
  description = "ssh"
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = "${aws_security_group.main.id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress" {
  security_group_id = "${aws_security_group.main.id}"
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

output "ip" {
  value = "${aws_instance.main.public_ip}"
}
