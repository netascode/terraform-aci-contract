<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-contract/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-contract/actions/workflows/test.yml)

# Terraform ACI Contract Module

Manages ACI Contract

Location in GUI:
`Tenants` » `XXX` » `Contracts` » `Standard`

## Examples

```hcl
module "aci_contract" {
  source  = "netascode/contract/aci"
  version = ">= 0.1.0"

  tenant      = "ABC"
  name        = "CON1"
  alias       = "CON1-ALIAS"
  description = "My Description"
  scope       = "global"
  subjects = [{
    name          = "SUB1"
    alias         = "SUB1-ALIAS"
    description   = "Subject Description"
    service_graph = "SG1"
    filters = [{
      filter   = "FILTER1"
      action   = "deny"
      priority = "level1"
      log      = true
      no_stats = true
    }]
  }]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Tenant name. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Contract name. | `string` | n/a | yes |
| <a name="input_alias"></a> [alias](#input\_alias) | Contract alias. | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | Contract description. | `string` | `""` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | Contract scope. Choices: `application-profile`, `tenant`, `context`, `global`. | `string` | `"context"` | no |
| <a name="input_subjects"></a> [subjects](#input\_subjects) | List of contract subjects. Choices `action`: `permit`, `deny`. Default value `action`: `permit`. Choices `priority`: `default`, `level1`, `level2`, `level3`. Default value `priority`: `default`. Default value `log`: `false`. Default value `no_stats`: `false`. | <pre>list(object({<br>    name          = string<br>    alias         = optional(string)<br>    description   = optional(string)<br>    service_graph = optional(string)<br>    filters = optional(list(object({<br>      filter   = string<br>      action   = optional(string)<br>      priority = optional(string)<br>      log      = optional(bool)<br>      no_stats = optional(bool)<br>    })))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `vzBrCP` object. |
| <a name="output_name"></a> [name](#output\_name) | Contract name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest_managed.vzBrCP](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vzRsSubjFiltAtt](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vzRsSubjGraphAtt](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vzSubj](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
<!-- END_TF_DOCS -->