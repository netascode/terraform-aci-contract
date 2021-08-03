output "dn" {
  value       = aci_rest.vzBrCP.id
  description = "Distinguished name of `vzBrCP` object."
}

output "name" {
  value       = aci_rest.vzBrCP.content.name
  description = "Contract name."
}
