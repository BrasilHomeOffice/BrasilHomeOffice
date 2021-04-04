# Local Infrastructure

The local infrastructure should work
in any developer machines.

To do this, we require
node, terraform and docker to be installed.

Both technologies were chosen for their
stability and ease of installation in the
local environment.

## Requirements

* Node
* Terraform CLI
* Docker
* To read README.md files

## Terraform Variables file

When you run `scripts/setup.sh`,
a terraform tfvars file is created.

./terraform/config.tfvars

You can use this file to customize
your environment according to your needs.

> NOTE:
> 
> Don't worry about the other files on the same folder.

<!--

 * @TODO_INFRA:
 *  Remove the extrafiles from there
 *  and put on a custom "generated" folder

The file `env/local/terraform/example.tfvars` should be copied into
`env/local/terraform/config.tfvars`.

This is usually done automatically by `scripts/setup.sh`.

---

Files for you to edit:

* `local/terraform/main.tf`
* `local/terraform/example.tfvars`
* `local/terraform/config.tfvars`
* `scripts/update-my-environment.sh`

> Please tell everyone when they need to update their environment.
> 
> And ask them to run `scripts/update-my-environment.sh`
> (that you should update too).

-->

## Important Notes

* [Documentation about docker provider for Terraform](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs)
* `local/terraform/config.tfvars` is a private file of each developer/architect and shall never be commited to git repository.
