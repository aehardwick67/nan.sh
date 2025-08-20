#!/bin/bash
# This script is a main script that skips FSCK and instead just runs updates and a core restart
echo -e "___________________________________________________________________"
echo -e "Running nan.sh V1.1.8-1b (pre-beta)"
sleep 0.5s
echo -e "For more information on the updates: view the Changelog"
sleep 0.5s
echo -e "Always check for updates & Ensure you have the correct distro"
echo -e "of this script for your system specific needs"
sleep 0.5s
echo -e "For a custom versions of this script contact business.aehardwick67@gmail.com"
#add a space between distro announcement and contact section
echo -e "___________________________________________________________________"
echo -e "                                                                   "
sleep 1.5s

# announce maintanance started
sudo wall "system maintanance has started"
sleep 1.5s

# update and remove redundent packages / if failure occurs run run.sh
echo -e "--------**Checking for updates**--------"
sudo apt update || echo -e /a "something went wrong, please run run.sh to fix the issue" || exit "1"
sleep 1.5s

echo -e "---------**applying updates**---------"
sudo apt upgrade -y || echo -e /a "something went wrong, please run run.sh to fix the issue" || exit "1"
sleep 1.5s

echo -e "---------**removing orphaned update files**---------"
sudo apt autoremove || echo -e /a "something went wrong, please run run.sh to fix the issue" || exit "1"
sleep 1s

# restart critical system prossesses
echo -e "---------**Restarting system services**--------"
sudo systemctl restart dhcpcd &&  echo -e  "dhcpcd - Restarted"
sleep 0.5s
sudo systemctl restart pihole-FTL && echo -e "pihole-FTL - Restarted"
sleep 0.5s
sudo systemctl restart chrony && echo -e "chrony - Restarted"
sleep 0.5s
sudo systemctl restart samba && echo -e "samba - Restarted"
sleep 1s

# update Pi-Hole and Gravity lists
echo -e "---------**Updating Pi-Hole**---------"
sudo pihole -up
sleep 1s

echo -e "---------**update FTL Lists**---------"
sudo pihole -g
sleep 1s

# provide status to user on FTL service status
sleep 0.5s
echo -e "---------**Checking FTL DNS status**---------"
sudo pihole status

# check chrony tracking
sleep 1s

echo -e "---------**NTP server tracking**---------"
sudo chronyc tracking
sleep 2s

# Command end
echo -e "---------**script end!**---------"
sudo wall "system maintanance complete"
exit "0"

# changelog V1.1.8-1b (pre-beta): update function seperation, system wide alert and script optimization
# changelog V1.1.8-1b (alpha): script output optimization for easier to read outputs
# changelog V1.1.8-1b: bug fixes and further optimization changes
# changelog V1.1.8-b: optimization changes, added pauses for system safety
# changelog V1.1.8: minor optimization changes
# changelog V1.1.4: minor changes to fix iconsitacies
# changelog V1.1.2: Swap wall for echo due to issues regarding double broadcast or no broadcast leaving the  wall command in this regards UNRELIABLE.
# changelog V1.1.0: introduction of the changelog for V1.1 distro