---
title: "2023-11: Node failure incident response"
description: |
  Motherboard was replaced in response to this incident.
---

## Hardware changes

* Ordered a replacement `Supermicro X9SCL-F rev1.11a` from eBay (~$20 + shipping).
* TODO: Install


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
  * Symptoms unchanged with multiple PSUs, PSU cables, and wall outlets.


## TODO

- [x] Diagnose failed part(s)
- [x] Order replacement part(s)
- [ ] Install replacement part(s)
