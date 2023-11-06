---
title: "How to add a disk"
---

## Pass through to VM

Add a pass-through disk by filling in this template. Look at the existing passed through
disks and increment the `virtio` ID by 1. Always use `by-id` identifiers for disks
instead of e.g. `/dev/sda`, as the latter can change between boots.

```bash
qm set <VMID> -virtio<ID> /dev/disk/by-id/ata-<ID>
```

e.g. if I already have `virtio1`-`virtio4` on VMID `100`, I would add `virtio5`:

```bash
qm set 100 -virtio5 /dev/disk/by-id/ata-HGST_XXXXXXXXXXXXXXX_XXXXXXXX
```
