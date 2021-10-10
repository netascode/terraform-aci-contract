
locals {
  subj_filter_list = flatten([
    for subj in var.subjects : [
      for flt in coalesce(subj.filters, []) : {
        id         = "${subj.name}-${flt.filter}"
        subj       = subj.name
        filter     = flt.filter
        action     = flt.action != null ? flt.action : "permit"
        directives = join(",", concat(flt.log == true ? ["log"] : [], flt.no_stats == true ? ["no_stats"] : []))
        priority   = flt.priority != null ? flt.priority : "default"
      }
    ]
  ])
}

resource "aci_rest" "vzBrCP" {
  dn         = "uni/tn-${var.tenant}/brc-${var.name}"
  class_name = "vzBrCP"
  content = {
    name      = var.name
    nameAlias = var.alias
    descr     = var.description
    scope     = var.scope
  }
}

resource "aci_rest" "vzSubj" {
  for_each   = { for subj in var.subjects : subj.name => subj }
  dn         = "${aci_rest.vzBrCP.id}/subj-${each.value.name}"
  class_name = "vzSubj"
  content = {
    name        = each.value.name
    nameAlias   = each.value.alias
    descr       = each.value.description
    revFltPorts = "yes"
  }
}

resource "aci_rest" "vzRsSubjFiltAtt" {
  for_each   = { for filter in local.subj_filter_list : filter.id => filter }
  dn         = "${aci_rest.vzSubj[each.value.subj].dn}/rssubjFiltAtt-${each.value.filter}"
  class_name = "vzRsSubjFiltAtt"
  content = {
    action           = each.value.action
    tnVzFilterName   = each.value.filter
    directives       = each.value.directives
    priorityOverride = each.value.priority
  }
}

resource "aci_rest" "vzRsSubjGraphAtt" {
  for_each   = { for subj in var.subjects : subj.name => subj }
  dn         = "${aci_rest.vzSubj[each.key].dn}/rsSubjGraphAtt"
  class_name = "vzRsSubjGraphAtt"
  content = {
    tnVnsAbsGraphName = each.value.service_graph
  }
}
