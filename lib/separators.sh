#!/usr/bin/env bash
# lib/separators.sh — separator sets: round | sharp | slanted | bare
# Sourced after config is loaded; CCS_SEPARATOR_STYLE must already be set.

case "${CCS_SEPARATOR_STYLE:-round}" in
  round)
    SEP_HARD=$'\ue0b4'   # U+E0B4  right round solid
    SEP_THIN=$'\ue0b5'   # U+E0B5  right round thin
    SEP_BEGIN=$'\ue0b6'  # U+E0B6  left round solid
    SEP_END=$'\ue0b4'    # U+E0B4  right round solid (end cap)
    ;;
  sharp)
    SEP_HARD=$'\ue0b0'   # U+E0B0  right arrow solid
    SEP_THIN=$'\ue0b1'   # U+E0B1  right arrow thin
    SEP_BEGIN=$'\ue0b2'  # U+E0B2  left arrow solid
    SEP_END=$'\ue0b0'    # U+E0B0  right arrow solid (end cap)
    ;;
  slanted)
    SEP_HARD=$'\ue0b8'   # U+E0B8  right slant solid
    SEP_THIN=$'\ue0b9'   # U+E0B9  right slant thin
    SEP_BEGIN=$'\ue0ba'  # U+E0BA  left slant solid
    SEP_END=$'\ue0b8'    # U+E0B8  right slant solid (end cap)
    ;;
  bare)
    SEP_HARD=' '
    SEP_THIN='|'
    SEP_BEGIN=''
    SEP_END=''
    ;;
esac
