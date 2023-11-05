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

Hot-swap drives are largely exposed as _UnionFS_ drive pools, with parity provided by
SnapRAID.


### Pool 1

3x 4TB HDDs. 2 data disks totaling 8TB of storage. 1 parity disk (4TB).


### Pool 2

3x 8TB HDDs. 2 data disks totaling 16TB of storage. 1 parity disk (8TB).


### Considerations

When I add more disks, consider combining the pools. The current set up is to compromise
between maximizing available storage and tolerance for drive failures.

Pros:

* Can tolerate 1 drive failure, 2 if I'm lucky and they happen on separate pools.
* 24TB of storage available.

Cons:

* If two drives on the same pool fail, I'm in trouble. Combining the pool and having two
  parity drives would allow two arbitrary drives to fail.
