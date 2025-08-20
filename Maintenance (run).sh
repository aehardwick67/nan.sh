#!/bin/bash

# welcome to my custom command to maintain my Raspberry Pi-Hole

wall "running System File Check" || echo -e /a "running system file check (broadcast failed)"

#check system files and repair / run again in background only if the scan fails
sudo fsck -fvy /dev/mmcblk0p1 || sudo fsck -fvy /dev/mmcblk0p1 &

# update package data

wall "checking for updates, updating packages and removing redundant packages" || echo -e /a "checking for updates, updating packages and removing redundant packages (broadcast failed)"

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

# restart critical system prossesses

wall "restarting system services" || echo -e /a "restarting system services (Broadcast failed)"

sudo systemctl restart dhcpcd
sudo systemctl restart pihole-FTL
sudo systemctl restart chrony
sudo systemctl restart samba

# update Pi-Hole and Gravity lists

wall "updating Pihole" || echo -e /a "updating Pi-Hole (broadcast failed)"

sudo pihole -up
sudo pihole -g

# Command end

wall "command done!" || echo -e /a "command done! (broadcast failed)"