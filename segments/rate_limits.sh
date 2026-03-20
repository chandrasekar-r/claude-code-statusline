#!/usr/bin/env bash
# segments/rate_limits.sh — 5h / 7d rate limit percentages
#
# Uses the same background as cost (BG_COST) so hard separator is invisible.

segment_rate_limits() {
  local five_h="${CCS_J_FIVE_H}"
  local seven_d="${CCS_J_SEVEN_D}"

  if [ "${CCS_RATELIMIT_HIDE_IF_EMPTY:-true}" = "true" ] && \
     [ -z "$five_h" ] && [ -z "$seven_d" ]; then
    return 1
  fi

  local text=""
  [ -n "$five_h"  ] && text+=" ${DIM}${SEG_RATE_FG}5h:$(printf "%.0f" "$five_h")%${RST}${BG_COST}"
  [ -n "$seven_d" ] && text+=" ${DIM}${SEG_RATE_FG}7d:$(printf "%.0f" "$seven_d")%${RST}${BG_COST}"
  text+=" "

  SEGMENT_TEXT="$text"
  SEGMENT_BG="$BG_COST"
  SEGMENT_FG_NEXT="$BG_COST_IDX"
  return 0
}
