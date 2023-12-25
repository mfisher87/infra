---
title: "Storage node"
---

The first node I set up long ago to act as a NAS, this node provides storage services,
but also runs some end-user services.

Originally built maybe a decade ago from new parts and used parts I had in stock.
Upgraded over time and eventually migrated in to a Supermicro 12-bay hotswap chassis.


## Storage

A total of 14 ports (6 motherboard SATA + 8 SAS expander PCI card). 12 are exposed as
hot-swap drive bays.


### Pool 1

A _UnionFS_ pool with *21TB* of storage capacity.

Redundancy provided by 2x _SnapRAID_ parity disks. Can tolerate 2 disk failures.


#### Data

* 3x 4TB HDDs
* 1x 8TB HDD
* 1x 1TB HDD


#### Parity

* 2x 8TB HDDs


### Considerations

When I add more disks, consider combining the pools. The current set up is to compromise
between maximizing available storage and tolerance for disk failures.

Pros:

* Can tolerate 1 disk failure, 2 if I'm lucky and they happen on separate pools.
* 24TB of storage available.

Cons:

* If two disks on the same pool fail, I'm in trouble. Combining the pool and having two
  parity disks would allow two arbitrary disks to fail.
