data "oci_identity_compartments" "compartment" {
  compartment_id = var.compartment_id
}

locals {
  tags_user = {
    "tf-name"        = var.name
    "tf-type"        = "iam-user"
    "tf-compartment" = "${data.oci_identity_compartments.compartment.name}"
  }
}

resource "oci_identity_user" "create_user" {
  name           = var.name
  compartment_id = var.compartment_id
  description    = var.description
  email          = var.email
  defined_tags   = var.defined_tags
  freeform_tags  = merge(var.tags, var.use_tags_default ? local.tags_user : {})
}

resource "oci_identity_user_group_membership" "create_attachment_group_on_user" {
  for_each = { for index, group_id in var.user_groups_ids : index => group_id }

  group_id = each.value
  user_id  = oci_identity_user.create_user.id
}

resource "oci_identity_policy" "create_policy" {
  for_each = { for index, policy in var.policies : index => policy }

  name           = each.value.name
  compartment_id = each.value.compartment_id
  description    = each.value.description
  statements     = each.value.statements
  version_date   = each.value.version_date
  defined_tags   = each.value.defined_tags

  freeform_tags = merge(each.value.freeform_tags, var.use_tags_default ? {
    "tf-name" = each.value.name
    "tf-type" = "policy"
  } : {})
}
