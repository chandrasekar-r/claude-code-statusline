#!/usr/bin/env bash
# segments/dir.sh — current working directory

segment_dir() {
  local short_cwd
  short_cwd="$(shorten_path "${CCS_J_CWD}")"

  SEGMENT_TEXT=" ${BOLD}${SEG_DIR_FG}${short_cwd} ${RST}"
  SEGMENT_BG="$BG_DIR"
  SEGMENT_FG_NEXT="$BG_DIR_IDX"
  return 0
}
