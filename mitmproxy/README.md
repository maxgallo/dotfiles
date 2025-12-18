# Mitmproxy cheatsheet

alias mitm='networksetup -setsecurewebproxystate Wi-Fi on && mitmproxy && networksetup -setsecurewebproxystate Wi-Fi off'

sudo networksetup -setwebproxy "Wi-Fi" 127.0.0.1 8080
sudo networksetup -setsecurewebproxy "Wi-Fi" 127.0.0.1 8080

sudo networksetup -setwebproxy "Wi-Fi" off
sudo networksetup -setsecurewebproxy "Wi-Fi" off


## iOS Simulator
go to http://mitm.it on iOS simulator and download the cert
Settings > General > VPN & DEvice Management > mitmproxy > Install
Settings > Trusted Certificate > Enable Full Trust for Root Certificates


https://vladzz.medium.com/setting-up-mitmproxy-on-ios-simulator-4a7f9889c2fc


## Keys
- Ctrl-f page down
- Ctrl-b page up
- F toggle "follow" mode
