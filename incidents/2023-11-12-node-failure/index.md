---
title: "2023-11-12: Node failure"
description: "TODO"
---

Why is everything failing at the same time?

After a full shutdown to turn off power to do electrical work, the Data Node now power
cycles about once per second instead of booting. There's a brief hard drive noise in
each cycle, but no beep from the motherboard speaker. The boot loop can be stopped by
holding the power button.


## Diagnosis

Diagnosed a motherboard failure. Rationale:

  * Symptoms began after a full shutdown.
  * Symptoms:
      * Fans spin for ~1 second on pushing power button, then stop. Repeats after ~1
        second delay, indefinitely.
      * No display
      * No beep from built-in speaker
      * No POST
      * Power cycling stops after holding powr button for 5 seconds.
  * Symptoms unchanged when removing all components (one by one): disks, RAM sticks,
    CPU.
  * Symptoms unchanged when replacing (one by one): PSU, PSU cables, wall outlets, CMOS
    CR2032 battery.
  * Symptoms unchanged with multiple PSUs, PSU cables, and wall outlets.
