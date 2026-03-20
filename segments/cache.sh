#!/usr/bin/env bash
# segments/cache.sh — cache read / cache written indicators
#
# Uses the same background as the tokens segment (BG_TOKENS) so the hard
# separator between tokens→cache is invisible (fg=bg). A thin separator
# in the segment text provides the visual divider.

segment_cache() {
  local cache_read="${CCS_J_CACHE_READ:-0}"
  local cache_write="${CCS_J_CACHE_WRITE:-0}"

  local has_read=false has_write=false
  [ "$cache_read"  -gt 0 ] 2>/dev/null && has_read=true
  [ "$cache_write" -gt 0 ] 2>/dev/null && has_write=true

  if [ "${CCS_CACHE_HIDE_IF_ZERO:-true}" = "true" ] && \
     [ "$has_read" = "false" ] && [ "$has_write" = "false" ]; then
    return 1
  fi

  local text=" ${SEG_CACHE_WRITE_FG}${SEP_THIN}${RST}${BG_TOKENS}"

  if $has_read; then
    local cr_fmt
    cr_fmt="$(fmt_tokens "$cache_read")"
    text+=" ${SEG_CACHE_FG}${ICON_CACHE_READ} ${cr_fmt} cached${RST}${BG_TOKENS}"
  fi
  if $has_write; then
    local cw_fmt
    cw_fmt="$(fmt_tokens "$cache_write")"
    text+=" ${SEG_CACHE_WRITE_FG}${ICON_CACHE_WRITE} ${cw_fmt} written${RST}${BG_TOKENS}"
  fi
  text+=" "

  SEGMENT_TEXT="$text"
  SEGMENT_BG="$BG_TOKENS"
  SEGMENT_FG_NEXT="$BG_TOKENS_IDX"
  return 0
}
