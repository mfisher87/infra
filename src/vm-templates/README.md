# VM Templates

Proxmox VM templates, automatically created with Packer.


## Prereqs

### Install Packer

https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli

:::{.callout-warning}
Though tempting, I would avoid using the version of Packer that may be available in your
OS repos unless you're certain it's recent. OS repos are often at least a year
out-of-date, and Packer has advanced significantly in that time.
:::


### Install the [Proxmox Packer plugin](https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox)

```bash
packer plugins install github.com/hashicorp/proxmox
```

Alternately, you can define the plugin in Packer config and install with `packer init`.


### Variables & secrets

Secrets and other variables should be managed in `*.auto.pkrvar.hcl` files within the
respective template directories. They'll be automatically picked up by Packer due to
their filename.

> [!IMPORTANT]
>
> **These should never be committed**, and are `.gitignore`d.


## Directory structure

In each template directory, there are additional files and directories.


### `http/` directory

This is where cloud-init config, which is hosted by a Packer HTTP server during
provisioning, lives.


## Usage

`cd` into a template directory and run a command to validate or build that template.


### Validate

```bash
packer validate .
```


### Build

```bash
packer build .
```

This will create a VM template in Proxmox.


### Instantiating a VM from clone

Right-click the template and select "Clone". A "Linked clone" is fast, but depends on
the template. A "Full clone" is slower and independent.

:::{.callout-warning}
It is *very important* to set the IP config in the cloud-init settings of the new VM,
otherwise networking will fail.
:::


## References

* https://ronamosa.io/docs/engineer/LAB/proxmox-packer-vm/
* https://github.com/ChristianLempa/homelab | https://github.com/ChristianLempa/boilerplates
* https://dev.to/aaronktberry/creating-proxmox-templates-with-packer-1b35


## TODO

### Think of a better way to organize this

Having this in a `src/` directory separate from the docs is not really what I'm looking
for. Should there be a doc directory dedicated to VM provisioning, and the source and
docs can live there together?


### Is there a better way to invoke Packer?

(Some of?) Packer's relative paths, like `http_directory`, seem to be evaluated relative
to `$PWD`, as opposed to relative to the config file like I'd expect. I'm not 100% sure
if this is true or if there's a setting to control this behavior.
