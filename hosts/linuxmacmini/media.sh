#!/bin/bash
# Media share for Infuse on the iPad / Apple TV: a Samba share of /srv/media, found
# over Bonjour (avahi). Guests can watch, only $USER can write. Run from the repo root:
#   ./hosts/linuxmacmini/media.sh
# The share password is stored by Samba in /var/lib/samba, not in this repo.
source ./utils/confirm.sh
source ./utils/log.sh

media_dir=/srv/media
share_conf=/etc/samba/media.conf
include_line="include = $share_conf"
apt_packages="samba avahi-daemon"

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to remove the media share? (files in $media_dir are kept)" || exit

    echo "Removing the share"
    sudo sed -i "\|^$include_line\$|d" /etc/samba/smb.conf
    sudo rm -f "$share_conf"
    sudo smbpasswd -x "$USER" 2> /dev/null
    sudo systemctl restart smbd

    echo "Kept: $media_dir and the samba / avahi packages (sudo apt-get purge samba to drop them)"
    exit
fi

logStep "Installing Samba and avahi"
missing=""
for package in $apt_packages; do
    dpkg -s "$package" > /dev/null 2>&1 || missing="$missing $package"
done
if [ -n "$missing" ]; then
    sudo apt-get update && sudo apt-get install -y $missing || exit 1
else
    echo "already installed"
fi

logStep "Creating $media_dir"
sudo mkdir -p "$media_dir/movies" "$media_dir/tv-shows"
# Not -R: only the folders, so a re-run doesn't touch the files in them
sudo chown "$USER:$USER" "$media_dir" "$media_dir/movies" "$media_dir/tv-shows"
ls "$media_dir"

logStep "Sharing $media_dir as 'media'"
# Anyone on the network can watch as a guest, only $USER can add / delete.
# fruit makes macOS Finder happy (resource forks, .DS_Store)
share_settings=$(cat << EOF
[media]
    path = $media_dir
    guest ok = yes
    read only = yes
    write list = $USER
    browseable = yes
    vfs objects = catia fruit streams_xattr
    fruit:metadata = stream
    fruit:veto_appledouble = no
    fruit:wipe_intentionally_left_blank_rfork = yes
    fruit:delete_empty_adfiles = yes
EOF
)
config_changed=false
if [ "$share_settings" == "$(cat "$share_conf" 2> /dev/null)" ]; then
    echo "already shared"
else
    echo "$share_settings" | sudo tee "$share_conf" > /dev/null
    config_changed=true
fi
if ! grep -qx "$include_line" /etc/samba/smb.conf; then
    echo "$include_line" | sudo tee -a /etc/samba/smb.conf
    config_changed=true
fi
testparm -s 2> /dev/null | grep -A4 '^\[media\]'

logStep "Setting the share password for $USER"
if sudo pdbedit -L 2> /dev/null | grep -q "^$USER:"; then
    echo "already set, change it with: sudo smbpasswd $USER"
else
    sudo smbpasswd -a "$USER" || exit 1
fi

sudo systemctl enable --now smbd avahi-daemon > /dev/null 2>&1
# reload, not restart: open connections (someone watching) stay up
[ "$config_changed" == true ] && sudo smbcontrol smbd reload-config

echo ""
echo "Done. Watch as a guest, add files as '$USER' with the password you just set:"
echo "  Infuse:  Add Files > Add Share > $(hostname) (or SMB, $(hostname -I | awk '{print $1}')), as guest"
echo "  Finder:  smb://$(hostname).local/media, as registered user $USER"
