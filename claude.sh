#!/bin/bash
source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/check.sh
source ./utils/log.sh
source ./utils/file_system.sh

check "jq" || (echo "we need jq to edit the Claude settings :(" ; exit)

claude_settings=~/.claude/settings.json

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to remove the Claude Code status line?" || exit

    echo "Removing ~/.claude/statusline.sh symlink"
    removeIfExists ~/.claude/statusline.sh

    if [ -f "$claude_settings" ]; then
        echo "Removing the statusLine entry from $claude_settings"
        jq 'del(.statusLine)' "$claude_settings" > "$claude_settings.tmp" \
            && mv "$claude_settings.tmp" "$claude_settings"
    fi

    exit
fi

logStep "Symlinking statusline.sh file"
mkdir -p ~/.claude
removeIfExists ~/.claude/statusline.sh
ln -s "$dotfiles_folder/claude/statusline.sh" ~/.claude/statusline.sh

logStep "Pointing $claude_settings to the status line"
[ -f "$claude_settings" ] || echo '{}' > "$claude_settings"
jq '.statusLine = { "type": "command", "command": "~/.claude/statusline.sh", "padding": 0 }' \
    "$claude_settings" > "$claude_settings.tmp" \
    && mv "$claude_settings.tmp" "$claude_settings"

echo "Status line preview:"
echo '{}' | ~/.claude/statusline.sh
