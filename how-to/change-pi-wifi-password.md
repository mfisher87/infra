---
title: "Change RPi wifi password"
---

Recently someone exposed my wifi password, so I had to change it. The most annoying part
was dealing with my Raspberry Pis and other headless single board computers.


## If you can SSH

If you can SSH to your Pi because, for example, it's near a convenient ethernet port,
life is easy. Edit `/etc/wpa_supplicant/wpa_supplicant.conf` and replace your old
password with your new password. 

Apply the change with `wpa_cli -i wlan0 reconfigure` and wait for the Pi to connect.
Monitor `ip addr show wlan0` to see if the device is assigned an IP address from your
router.


## If you can't SSH

Remove the SD card from the Pi, insert it in to another machine, and drop a
`wpa_supplicant.conf` file on to it. It might look like:

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
country=US
update_config=1

network={
  ssid="MySSID"
  psk="MyPassword"
}
```
