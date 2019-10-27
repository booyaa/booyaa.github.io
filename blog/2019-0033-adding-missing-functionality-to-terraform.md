---
permalink: "/2019/adding-missing-functionality-to-terraform"
title: "Adding missing functionality to Terraform"
categories:
  - "terraform"
layout: post.liquid
published_date: "2019-10-27 13:37:00 +0000"
is_draft: false
data:
  tags: "terraform"
  route: blog
---

I needed to codify the creation of PostgreSQL read replicas, so I did a bit of research around ways I could do this quickly without diving into the Terraform [provider][tf_azure].

The quickest way to do this was to:

- use the [`local-exec`][tf_local_exec] provisioner to invoke the Azure CLI commands (details to follow)
- wrap the code in a module (to allow for reuse and share with the community)

The Azure [docs][azure_docs] requires the following steps to be carried out to create a read replica using the Azure CLI are:

- Enable replication support on the primary server
- Restart the primary server (for the changes to take effect)
- Create the replica using the primary server as the source

Caveat emptor: as the Terraform docs [mention][tf_local_exec], provisioners are a last resort. A major downside of using this method to add missing functionality is that there's no state tracking, i.e. if you make a change to the resource, Terraform won't know about it.

Here's the essence of the code (I've omitted certain details for brevity the full code is on [GitHub][gh_repo]):

```hcl
resource "null_resource" "postgresql-read-replica" {
  triggers = {
    resource_group_name            = var.resource_group_name
    postgresql_primary_server_name = var.postgresql_primary_server_name
    postgresql_replica_server_name = var.postgresql_replica_server_name
  }
```

The [`null_resource`][tf_null] is also provisioner is used as a container for the `local_exec` calls. The `triggers` block allows the resource to be replaced, i.e. destroyed and recreated when the resource group, the PostgreSQL primary or replica server names changes.

You can already see that [modules][tf_modules] are just ordinary bits of Terraform code.

```hcl
  provisioner "local-exec" {
    command = <<ENABLE_REPLICATION
az postgres server configuration set \
...
ENABLE_REPLICATION
  }

  provisioner "local-exec" {
    command = <<RESTART_SERVER
az postgres server restart \
...
RESTART_SERVER
  }

  provisioner "local-exec" {
    command = <<CREATE_REPLICA
az postgres server replica create \
...
CREATE_REPLICA
  }
```

These three provisioner blocks perform the required actions to create a read replica using the Azure CLI. To avoid having to escape quotes we're using the [here doc][wiki_heredoc] notation.

```hcl
  provisioner "local-exec" {
    when = "destroy"
    command = <<DESTROY_REPLICA
az postgres server delete \
  --name ${var.postgresql_replica_server_name} \
  --resource-group ${var.resource_group_name} \
  --yes
DESTROY_REPLICA
  }
}
```

Finally, we handle when what to do when the replica is destroyed.

I've uploaded the module to the Terraform [registry][tf_registry] which means the module can be easily referenced just like another resource:

```hcl
module demo-replica {
  source                         = "booyaa/terraform-azurerm-postgresql-read-replica"
  resource_group_name            = azurerm_resource_group.demo.name
  postgresql_primary_server_name = azurerm_postgresql_server.demo.name
  postgresql_replica_server_name = "${azurerm_postgresql_server.demo.name}-replica"
}
```

Just like the [Data Sources][tf_datasources], modules can be used as a reference so we can now apply a firewall rule against the read replica:

```hcl
resource "azurerm_postgresql_firewall_rule" "demo-replica" {
  name                = "office"
  resource_group_name = azurerm_resource_group.demo.name
  server_name         = module.demo-replica.replica_name
  start_ip_address    = "8.8.8.8"
  end_ip_address      = "8.8.8.8"

  depends_on = [module.demo-replica]
}
```

<!-- links -->

[azure_docs]: https://docs.microsoft.com/en-us/azure/postgresql/howto-read-replicas-cli
[tf_azure]: https://www.terraform.io/docs/providers/azurerm/
[tf_datasources]: https://www.terraform.io/docs/configuration/data-sources.html
[tf_local_exec]: https://www.terraform.io/docs/provisioners/local-exec.html
[tf_modules]: https://www.terraform.io/docs/modules/index.html
[tf_null]: https://www.terraform.io/docs/providers/null/resource.html
[tf_registry]: https://registry.terraform.io/modules/booyaa/postgresql-read-replica/azurerm/0.2.0
[gh_issue]: https://github.com/booyaa/terraform-azurerm-postgresql-read-replica
[gh_repo]: https://github.com/booyaa/terraform-azurerm-postgresql-read-replica
[wiki_heredoc]: https://en.wikipedia.org/wiki/Here_document