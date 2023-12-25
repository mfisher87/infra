---
title: "2023-10-28: Disk failure"
description: |
  A 1TB HDD in the [storage node](/reference/nodes/storage.md) failed. This drive was
  used for VM backups, and (mistakenly) for a services VM disk. This resulted in minor
  data loss.
---

This disk was unfortunately unprotected, because I figured it was just VM backups and if
it died, I could replace it and continue. This was perhaps a risky choice, but I also
made a big mistake by accidentally storing a live VM disk on this drive.

The data lost was unpushed service configuration changes, and potentially some
relatively unimportant secrets.


## Infrastructure changes

See the related [change document](/changes/2023-11-disk-failure-incident-response/index.md)
for more details about changes as a result of this incident.
