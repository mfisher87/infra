---
title: "2023-11: Disk failure incident response"
description: |
  New storage was added and a new pool was configured in response to this incident.
---

## Hardware changes

The failed 1TB HDD was removed.

Pool 1 was grown by adding 4TB and 8TB data disks, and 2x 8TB parity disks, increasing
drive failure tolerance to 2.


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
