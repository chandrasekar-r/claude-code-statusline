#!/usr/bin/env bash
# segments/vim_mode.sh — vim mode badge (N / I / V)
# This segment sets the same bg as model so it flows seamlessly after it,
# or can be ordered independently.

segment_vim_mode() {
  local mode="${CCS_J_VIM_MODE}"
  [ -z "$mode" ] && return 1

  local badge label
  case "$mode" in
    NORMAL)  badge="${BOLD}${SEG_VIM_NORMAL_FG}N${RST}" ;;
    VISUAL)  badge="${BOLD}${SEG_VIM_INSERT_FG}V${RST}" ;;
    *)       badge="${BOLD}${SEG_VIM_INSERT_FG}I${RST}" ;;
  esac

  SEGMENT_BG="$BG_MODEL"
  SEGMENT_TEXT=" ${badge}${BG_MODEL} "
  SEGMENT_FG_NEXT="$BG_MODEL_IDX"
  return 0
}
