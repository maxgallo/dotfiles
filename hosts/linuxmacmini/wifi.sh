#!/bin/bash
# Wifi on the built-in Broadcom BCM4360, which needs the proprietary wl driver
# (b43 loads for it but can't drive it). Run from the repo root, while still on ethernet:
#   ./hosts/linuxmacmini/wifi.sh
# The wifi password is stored by NetworkManager in /etc/NetworkManager, not in this repo.
source ./utils/confirm.sh
source ./utils/log.sh

apt_source=/etc/apt/sources.list.d/non-free.list
connection_name=wifi
apt_packages="linux-headers-amd64 broadcom-sta-dkms network-manager wpasupplicant"

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to remove the wifi setup?" || exit

    echo "Removing the $connection_name connection"
    sudo nmcli connection delete "$connection_name" 2> /dev/null

    echo "Removing the wl driver (b43 is no longer blacklisted)"
    sudo apt-get purge -y broadcom-sta-dkms
    sudo rm -f /etc/modprobe.d/broadcom-sta-blacklist.conf

    echo "Removing the non-free apt component"
    sudo rm -f "$apt_source"
    sudo apt-get update

    echo "Kept: network-manager and the kernel headers. Reboot to unload wl"
    exit
fi

if ! lspci -nn | grep -q '14e4:43a0'; then
    echo "No BCM4360 found, this script is only for the Mac mini's built-in wifi"
    exit 1
fi

logStep "Enabling the non-free apt component (broadcom-sta-dkms lives there)"
if apt-cache policy broadcom-sta-dkms | grep -q "Candidate: [0-9]"; then
    echo "already enabled"
else
    . /etc/os-release
    echo "deb http://deb.debian.org/debian/ $VERSION_CODENAME non-free" | sudo tee "$apt_source"
fi

logStep "Installing the wl driver, kernel headers and NetworkManager"
# Headers for the running kernel and for the latest one, so DKMS builds wl for both.
# NetworkManager leaves the ethernet alone: it's in /etc/network/interfaces (ifupdown)
missing=""
for package in "linux-headers-$(uname -r)" $apt_packages; do
    dpkg -s "$package" > /dev/null 2>&1 || missing="$missing $package"
done
if [ -n "$missing" ]; then
    sudo apt-get update && sudo apt-get install -y --no-install-recommends $missing || exit 1
else
    echo "already installed"
fi

logStep "Blacklisting the drivers that grab the card before wl"
if grep -rqs '^blacklist b43$' /etc/modprobe.d/; then
    echo "already blacklisted"
else
    printf 'blacklist %s\n' b43 b43legacy bcma ssb brcmsmac | sudo tee /etc/modprobe.d/broadcom-sta-blacklist.conf
fi

logStep "Swapping b43 for wl"
sudo modprobe -r b43 ssb bcma 2> /dev/null
sudo modprobe wl
for _ in 1 2 3 4 5; do
    wifi_interface=$(ls -d /sys/class/net/*/wireless 2> /dev/null | head -1 | cut -d/ -f5)
    [ -n "$wifi_interface" ] && break
    sleep 1
done
if [ -z "$wifi_interface" ]; then
    echo "No wifi interface showed up, check: sudo dmesg | grep -i wl"
    exit 1
fi
echo "wifi interface: $wifi_interface"

logStep "Connecting to wifi"
if nmcli -t -f NAME connection show | grep -qx "$connection_name"; then
    echo "the $connection_name connection already exists, change it with: sudo nmtui"
else
    sudo nmcli device wifi rescan 2> /dev/null
    nmcli -f SSID,SIGNAL,SECURITY device wifi list
    read -p "SSID: " wifi_ssid
    read -s -p "Password: " wifi_password
    echo
    sudo nmcli device wifi connect "$wifi_ssid" password "$wifi_password" \
        ifname "$wifi_interface" name "$connection_name" \
        || { sudo nmcli connection delete "$connection_name" 2> /dev/null; exit 1; }
    # Power saving on wl makes SSH laggy, and this is a plugged-in server
    sudo nmcli connection modify "$connection_name" 802-11-wireless.powersave 2
    sudo nmcli connection up "$connection_name"
fi

wifi_ip=$(ip -4 -br addr show "$wifi_interface" | awk '{print $3}' | cut -d/ -f1)
echo ""
echo "wifi IP: ${wifi_ip:-none yet}"
echo "Check that 'ssh $USER@$wifi_ip' works before unplugging the ethernet cable"
