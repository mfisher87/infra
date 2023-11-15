---
title: "2023-11-12: Node failure"
description: "TODO"
---

Why is everything failing at the same time?

After a full shutdown to turn off power to do electrical work, the Data Node now power
cycles about once per second instead of booting. There's a brief hard drive noise in
each cycle, but no beep from the motherboard speaker. The boot loop can be stopped by
holding the power button.


## Tried

* Replaced CMOS CR2032 battery: No change in symptoms
* Removed RAM: No change in symptoms
* Removed 5 disks: No change in symptoms


## To try

* Replace PSU
* Remove all disks: Label SATA cables, remove power connections
* Replace motherboard: I really hope not...
