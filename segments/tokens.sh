#!/usr/bin/env bash
# segments/tokens.sh — ↑↓ token counts + context bar

segment_tokens() {
  local total_in="${CCS_J_TOTAL_IN:-0}"
  local total_out="${CCS_J_TOTAL_OUT:-0}"
  local used_pct="${CCS_J_USED_PCT}"

  local in_fmt out_fmt
  in_fmt="$(fmt_tokens "$total_in")"
  out_fmt="$(fmt_tokens "$total_out")"

  local in_sym="${CCS_TOKENS_IN_SYMBOL:-↑}"
  local out_sym="${CCS_TOKENS_OUT_SYMBOL:-↓}"

  local text=" ${BOLD}${SEG_TOKENS_IN_FG}${in_sym}${in_fmt}${RST}${BG_TOKENS} ${SEG_TOKENS_OUT_FG}${out_sym}${out_fmt}${RST}${BG_TOKENS}"

  # Context window bar
  if [ "${CCS_TOKENS_SHOW_BAR:-true}" = "true" ] && [ -n "$used_pct" ]; then
    local ipct=${used_pct%.*}
    local cc bar
    cc="$(ctx_colour "$used_pct")"
    bar="$(ctx_bar "$ipct")"
    text+=" ${DIM}[${RST}${BG_TOKENS}${cc}${bar}${RST}${BG_TOKENS}${DIM}${ipct}%]${RST}${BG_TOKENS}"
  fi

  text+=" "

  SEGMENT_TEXT="$text"
  SEGMENT_BG="$BG_TOKENS"
  SEGMENT_FG_NEXT="$BG_TOKENS_IDX"
  return 0
}
