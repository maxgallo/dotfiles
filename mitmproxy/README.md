# Mitmproxy cheatsheet

alias mitm='networksetup -setsecurewebproxystate Wi-Fi on && mitmproxy && networksetup -setsecurewebproxystate Wi-Fi off'

sudo networksetup -setwebproxy "Wi-Fi" 127.0.0.1 8080
sudo networksetup -setsecurewebproxy "Wi-Fi" 127.0.0.1 8080

sudo networksetup -setwebproxy "Wi-Fi" off
sudo networksetup -setsecurewebproxy "Wi-Fi" off

OR

mitmproxy --mode local
:set showhost true
mitmproxy --mode local --set view_filter='~http' --set showhost=true


## iOS Simulator
go to http://mitm.it on iOS simulator and download the cert
Settings > General > VPN & DEvice Management > mitmproxy > Install
Settings > Trusted Certificate > Enable Full Trust for Root Certificates


https://vladzz.medium.com/setting-up-mitmproxy-on-ios-simulator-4a7f9889c2fc

## Android
enable proxy (starts by default at port 8080)
adb -s 192.168.0.238 shell settings put global http_proxy 192.168.0.100:8080

disable proxy
adb -s 192.168.0.238 shell settings put global http_proxy :0

## Filter
& AND
| OR
() group
~d dazn.com - domain
~m POST   - method
~t json   - content type
~c 404    - response code

## Keys
- Ctrl-f page down
- Ctrl-b page up
- F toggle "follow" mode

- z clear all flows
- f search

: save.har @all ~/Desktop/autoplay-black-screen.har

: cut.save @focus response.content ~/Desktop/manifest-nodrm-broken.mpd

