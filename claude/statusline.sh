#!/bin/bash
# Claude Code status line: folder, model, color-coded context bar, /usage-style limits.
# Receives session JSON on stdin.

input=$(cat)

# Single jq call (instead of one per field) to avoid forking a process per lookup.
# rate_limits is only present for Claude.ai subscribers, and only after the first
# API response of the session; both windows are individually optional, so they
# fall back to "" (not `empty`, which would drop the array slot entirely).
# Joined with \x1f (not @tsv's tab) because bash's `read` treats tab as IFS
# whitespace and collapses/strips leading empty fields.
IFS=$'\x1f' read -r dir model pct cost five_pct five_at week_pct week_at <<< "$(
  printf '%s' "$input" | jq -r '[
    .workspace.current_dir // "",
    .model.display_name // "",
    ((.context_window.used_percentage // 0) | floor),
    (.cost.total_cost_usd // 0),
    (.rate_limits.five_hour.used_percentage // ""),
    (.rate_limits.five_hour.resets_at // ""),
    (.rate_limits.seven_day.used_percentage // ""),
    (.rate_limits.seven_day.resets_at // "")
  ] | join("")'
)"

folder=$(basename "${dir:-$PWD}")
: "${model:=unknown}"
# used_percentage is null before the first API response; clamp to a sane 0-100.
[[ $pct =~ ^[0-9]+$ ]] || pct=0
((pct > 100)) && pct=100

GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'
CYAN='\033[36m'; MAGENTA='\033[35m'; DIM='\033[2m'; RESET='\033[0m'

# Shared thresholds so context and usage windows read the same way.
usage_color() {
  local p=$1
  if ((p > 70)); then printf '%s' "$RED"
  elif ((p >= 50)); then printf '%s' "$YELLOW"
  else printf '%s' "$GREEN"
  fi
}

# Coarse countdown to a reset, matching how /usage phrases it ("Resets in ...").
until_reset() {
  local at=$1 now diff
  [[ $at =~ ^[0-9]+$ ]] || return 1
  now=$(date +%s)
  diff=$((at - now))
  ((diff < 0)) && diff=0
  if ((diff >= 86400)); then printf '%dd %dh' $((diff / 86400)) $(((diff % 86400) / 3600))
  elif ((diff >= 3600)); then printf '%dh %dm' $((diff / 3600)) $(((diff % 3600) / 60))
  else printf '%dm' $((diff / 60))
  fi
}

# One "Label 42% ↻1h 12m" segment per rate-limit window.
window_segment() {
  local label=$1 raw_pct=$2 at=$3 p color left
  [[ -n $raw_pct ]] || return 1
  p=$(LC_NUMERIC=C awk -v p="$raw_pct" 'BEGIN { printf "%d", (p + 0 < 0 ? 0 : (p + 0 > 100 ? 100 : p + 0.5)) }')
  color=$(usage_color "$p")
  printf "%s %b%s%%%b" "$label" "$color" "$p" "$RESET"
  # A window can arrive without resets_at; the percentage alone still stands.
  left=$(until_reset "$at") && printf " %b↻%s%b" "$DIM" "$left" "$RESET"
  return 0
}

bar_color=$(usage_color "$pct")

# 20-cell bar: one cell per 5% used. ▮ is narrower than its cell, so the bar
# looks spaced out without padding characters between the cells. Used and unused
# cells are the same glyph, separated by colour rather than shape.
filled=$((pct / 5))
printf -v fill "%${filled}s"
printf -v pad "%$((20 - filled))s"
bar_used="${fill// /▮}"
bar_free="${pad// /▮}"

printf "${CYAN}%s${RESET} ${DIM}|${RESET} ${MAGENTA}%s${RESET} ${DIM}|${RESET} Context ${bar_color}%s${RESET}${DIM}%s${RESET} %s%%" \
  "$folder" "$model" "$bar_used" "$bar_free" "$pct"

if [[ -n $five_pct || -n $week_pct ]]; then
  if segment=$(window_segment Session "$five_pct" "$five_at"); then
    printf " ${DIM}|${RESET} %b" "$segment"
  fi
  if segment=$(window_segment Week "$week_pct" "$week_at"); then
    printf " ${DIM}|${RESET} %b" "$segment"
  fi
else
  # No subscription limits to report (API-key auth, or pre-first-response): fall
  # back to session cost so the slot still carries something.
  # Scale precision to the amount so early-session spend isn't rounded away to $0.00.
  # LC_NUMERIC=C keeps the decimal point a "." under any locale; c+0 coerces junk to 0.
  cost_fmt=$(LC_NUMERIC=C awk -v c="$cost" 'BEGIN {
    if (c + 0 <= 0)         printf "$0.00"
    else if (c + 0 >= 1)    printf "$%.2f", c
    else if (c + 0 >= 0.01) printf "$%.3f", c
    else                    printf "$%.4f", c
  }')
  printf " ${DIM}|${RESET} Cost ${GREEN}%s${RESET}" "$cost_fmt"
fi
 
