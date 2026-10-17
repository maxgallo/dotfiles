#!/bin/bash
# Bit-perfect music player for the McIntosh, connected over USB: MPD plays /srv/media/music
# straight to the amp's DAC (ALSA hw device, no resampling, no software volume) and is
# controlled from the iPhone / iPad with an MPD app (Rigelian, MaximumMPD), found over Bonjour.
# The amp must be on and plugged in. Run from the repo root:
#   ./hosts/linuxmacmini/music.sh
# The music lives in /srv/media, so media.sh already shares it over Samba too.
source ./utils/confirm.sh
source ./utils/log.sh

music_dir=/srv/media/music
mpd_conf=/etc/mpd.conf
apt_packages="mpd avahi-daemon alsa-utils rsync"

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to remove the music player? (files in $music_dir are kept)" || exit

    echo "Removing mpd and its config (library database, playlists)"
    sudo systemctl disable --now mpd.service mpd.socket 2> /dev/null
    sudo apt-get purge -y mpd

    echo "Kept: $music_dir, avahi-daemon, alsa-utils and rsync"
    exit
fi

logStep "Finding the McIntosh"
# The card's ALSA id (e.g. "Audio"), stable across reboots, unlike its number
card=$(awk -F'[][]' '/McIntosh/ { gsub(/ /, "", $2); print $2; exit }' /proc/asound/cards)
if [ -z "$card" ]; then
    echo "No McIntosh found in /proc/asound/cards, is the amp on and connected over USB?"
    exit 1
fi
echo "found: hw:CARD=$card"
grep -E 'Format|Rates' "/proc/asound/$card/stream0" | sort -u

logStep "Installing MPD, avahi, the ALSA tools and rsync (the Mac copies the music with it)"
missing=""
for package in $apt_packages; do
    dpkg -s "$package" > /dev/null 2>&1 || missing="$missing $package"
done
if [ -n "$missing" ]; then
    sudo apt-get update && sudo apt-get install -y --no-install-recommends $missing || exit 1
else
    echo "already installed"
fi

logStep "Creating $music_dir"
sudo mkdir -p "$music_dir"
# Not -R: only the folder, so a re-run doesn't touch the files in it
sudo chown "$USER:$USER" "$music_dir"
echo "$(df -h --output=avail "$music_dir" | tail -1 | tr -d ' ') free"

logStep "Configuring MPD for bit-perfect playback"
# hw: talks to the DAC directly, so no other program can mix or resample. Every auto_*
# conversion is off and there's no software mixer: volume is the amp's knob / remote.
# Files above 192kHz don't play, the McIntosh's USB input stops there.
mpd_settings=$(cat << EOF
music_directory     "$music_dir"
playlist_directory  "/var/lib/mpd/playlists"
db_file             "/var/lib/mpd/tag_cache"
state_file          "/var/lib/mpd/state"
sticker_file        "/var/lib/mpd/sticker.sql"
user                "mpd"
bind_to_address     "any"
port                "6600"
auto_update         "yes"
restore_paused      "yes"
zeroconf_enabled    "yes"
zeroconf_name       "McIntosh"
replaygain          "off"
volume_normalization "no"

audio_output {
    type            "alsa"
    name            "McIntosh"
    device          "hw:CARD=$card,DEV=0"
    mixer_type      "none"
    auto_resample   "no"
    auto_channels   "no"
    auto_format     "no"
}
EOF
)
config_changed=false
if [ "$mpd_settings" == "$(cat "$mpd_conf" 2> /dev/null)" ]; then
    echo "already configured"
else
    echo "$mpd_settings" | sudo tee "$mpd_conf" > /dev/null
    config_changed=true
    echo "written to $mpd_conf"
fi

logStep "Starting MPD"
# Socket activation would ignore bind_to_address, so MPD runs as a plain service
sudo systemctl disable --now mpd.socket > /dev/null 2>&1
sudo systemctl enable mpd.service avahi-daemon > /dev/null 2>&1
if [ "$config_changed" == true ]; then
    sudo systemctl restart mpd.service
else
    sudo systemctl start mpd.service
fi
systemctl is-active mpd.service

echo ""
echo "Done. Copy the music from the Mac (resumable: run it again to carry on or add new albums):"
echo "  caffeinate -i rsync -av --partial --progress --chmod=Dgo+rx,Fgo+r~/Music/<folder>/ $USER@$(hostname).local:$music_dir/"
echo "Control it from the iPhone / iPad with Rigelian or MaximumMPD: it shows up as 'McIntosh'"
echo "  ($(hostname).local, port 6600). Library changes are picked up by themselves."
echo "Check it's bit-perfect while a song plays (rate should match the file):"
echo "  cat /proc/asound/$card/pcm0p/sub0/hw_params"
