output "user" {
  description = "User"
  value       = try(oci_identity_user.create_user, null)
}

output "user_id" {
  description = "User ID"
  value       = try(oci_identity_user.create_user.id, null)
}

output "group_attachments" {
  description = "Group attachments"
  value       = try(oci_identity_user_group_membership.create_attachment_group_on_user, null)
}

output "policies" {
  description = "Policies"
  value       = try(oci_identity_policy.create_policy, null)
}
