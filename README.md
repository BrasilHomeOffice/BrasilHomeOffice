# Brasil Home Office

An initiative to strengthen the Brazilian economy,
bringing knowledge about home office work.

> @TODO ~ Put link here

## Features

* Architecture as Code
* Speeds up new employees' onboarding
* Multiple microservices
* Multi-repository / microservices architecture

## Local Env Requirements

* [Terraform CLI](https://www.terraform.io/) - for architecture as code
* [Docker](https://docs.docker.com/get-docker/) - for local development
* [Node](https://nodejs.org/en/) - for custom scripts
* [Git](https://linuxize.com/post/how-to-install-git-on-ubuntu-18-04/)
* Git sshkey configured
* Someone who really likes to read README.md files
* Ubuntu / Windows with WSL 2 and Ubuntu distro

## Infra TODOs

* Test and adapt for Mac

## Getting started

To setup your local environment, just run:

```
./scripts/setup.sh
```

Open in your browser:

---

http://local.brasilhomeoffice.com

or

http://local-ping.brasilhomeoffice.com

---

## Next steps

* [Add entries to your hosts file](./docs/required-hosts.md)

## Complete uninstall

To completely uninstall, run:

```
./scripts/uninstall.sh --remove-custom-config
```

> If you do not pass --remove-custom-config flag,
> then your file `infrastructure/env/local/terraform/config.tfvars`
> remains untouchable.
