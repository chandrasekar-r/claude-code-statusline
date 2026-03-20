#!/usr/bin/env bash
# segments/cost.sh — session cost + total token count

segment_cost() {
  local cost_raw="${CCS_J_COST}"
  local total_in="${CCS_J_TOTAL_IN:-0}"
  local total_out="${CCS_J_TOTAL_OUT:-0}"

  local total_all
  total_all=$(echo "$total_in + $total_out" | bc 2>/dev/null || echo 0)
  local total_fmt
  total_fmt="$(fmt_tokens "$total_all")"

  local dec="${CCS_COST_DECIMAL_PLACES:-4}"
  local cost_str=""

  if [ -n "$cost_raw" ] && [ "$cost_raw" != "null" ] && [ "$cost_raw" != "0" ]; then
    cost_str=" ${BOLD}${SEG_COST_FG}\$$(printf "%.${dec}f" "$cost_raw")${RST}${BG_COST} ${DIM}${FG_WHITE}|${RST}${BG_COST}"
  elif [ "${CCS_COST_HIDE_IF_ZERO:-true}" = "true" ] && [ -z "$cost_raw" ]; then
    cost_str=""
  fi

  local text="${cost_str} ${SEG_TOTAL_FG}${ICON_TOTAL} ${total_fmt} total${RST}${BG_COST}"

  SEGMENT_TEXT="$text"
  SEGMENT_BG="$BG_COST"
  SEGMENT_FG_NEXT="$BG_COST_IDX"
  return 0
}
