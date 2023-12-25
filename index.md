---
title: "My infrastructure"
---

## Current state

I have two physical nodes:

1. [Storage](/reference/nodes/storage.md): An older build from new parts in a Supermicro chassis with 12
   hotswap drive bays.
2. [Compute](/reference/nodes/compute.md): A newer build from used eBay parts in a Supermicro
   chassis with lots of airflow.


### Virtualization/containerization

Each of these nodes is running _Proxmox VE_. Software is deployed on VMs, enabling
deployment of virtual clustered systems.

Software is deployed on containers to the extent possible. Sometimes Docker Swarm,
sometimes Docker Compose, sometimes Kubernetes.

:::{.callout-note}
That may not even be a full listing of my deployment types...

TODO: Standardize my deployments!
:::


### Storage

My aim is to use simple solutions that minimize [cognitive
load](https://mfisher87.github.io/cognitive_load.html) and maximize flexibility.

:::{.callout-note}
I made a lot of these decisions a long time ago and don't have my full rationale
anymore. When I find / remember it, update here.
:::


#### Redundancy: _mdadm_

[_mdadm_](https://en.wikipedia.org/wiki/Mdadm) is a utility for managing software RAID.
I'm using this for operating system drives (mostly SSDs?) to enable servers to survive
drive failures.


#### Redundancy: _SnapRAID_

[_SnapRAID_](https://www.snapraid.it/) is a non-realtime software RAID solution. I'm
using this for shared storage drives. Parity is calculated and validated (bit-rot
protection) on a schedule.

I'm also using _UnionFS_ to expose data drives as a unified pool.

##### Rationale

* Data drives can be accessed in isolation of the array (even if the array can't be
  fully recovered).
* Data files are hashed to protect from bit rot.
* Arrays are flexible to change size, increase parity, etc.
    * Disks with data already on them can be added to the array.
* Only the disk being accessed will spin up.
* Between the scheduled parity recalculations, it's possible to "un-delete" files!


##### Considerations

* Parity drives must be among the largest in the pool. For now I have two pools until I
  get more drives and can re-organize them in to one pool.


### Network

1GbE


## Desired state

### Backups as a service

How to make automated (file-level) backups easier? Time to try out some new tools, e.g.
Borg, Restic?


### Energy efficiency

* How to get nodes to sleep when not in use?

* What services can run on more purpose-built hardware to save energy from e.g. software
  video encoding?

* How can I integrate SBCs (Raspberry Pi, oDroid N2+, H3+) to save energy?

* How best to monitor energy usage at the node/service level?
