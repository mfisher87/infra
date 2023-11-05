---
title: "2023-11: Disk failure incident response"
description: |
  New storage was added and a new pool was configured in response to this incident.
---

## Storage changes

As a result of this incident, the failed 1TB HDD was replaced with a 1TB HDD in storage
pool 1. A new 4TB HDD was purchesd to replace this drive in pool 1, increasing its
capacity from 5TB (4TB + 1TB data + 4TB parity) to 8TB (4TB + 4TB data + 4TB parity).

In addition, storage pool 2 was created from in stock 8TB disks to provide migration
space during recovery.


## Deployment changes

The VM which was mistakenly assigned to house its disk on this inappropriate drive will
need to be recreated from scratch to replace all the services that were running on it.


## Other changes

### Labels!

Finding the physical failed drive was far more of a challenge than I wanted it to be. I
printed labels for each drive bay on the [storage node](/nodes/storage.md) including:

* Internal SATA port the bay is connected to
* The drive model currently in the bay
* The capacity of the drive currently in the bay
* The functional purpose of the drive currently in the bay (e.g. `Pool1 Parity1`, `Pool2
  Data1`, etc.)
