#!/usr/bin/env bash
# wizard/step_separators.sh — step 2: separator style with live preview

wizard_step_separators() {
  clear
  printf "\033[1m\033[38;5;51mClaude Code Statusline — Setup Wizard\033[0m\n"
  printf "\033[2m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m\n\n"
  printf "\033[1mStep 2 / 5 — Separator style\033[0m\n\n"
  printf "Choose the separator style between statusline segments:\n\n"

  # Preview each style inline
  local R='\033[0m'
  local B1='\033[48;5;4m' B2='\033[48;5;17m' B3='\033[48;5;54m'
  local W='\033[38;5;255m' C='\033[38;5;51m' M='\033[38;5;201m'

  # round
  printf "  \033[1m1) round\033[0m   "
  printf "%b" "${B1}${W} ~/project ${R}\033[38;5;4m${B2}$'\ue0b4'${R}${B2}${C} Sonnet 4.6 ${R}\033[38;5;17m${B3}$'\ue0b4'${R}${B3}${M} ↑1.2k ↓4.5k ${R}\033[38;5;54m$'\ue0b4'${R}"
  printf "\n"

  # sharp
  printf "  \033[1m2) sharp\033[0m   "
  printf "%b" "${B1}${W} ~/project ${R}\033[38;5;4m${B2}$'\ue0b0'${R}${B2}${C} Sonnet 4.6 ${R}\033[38;5;17m${B3}$'\ue0b0'${R}${B3}${M} ↑1.2k ↓4.5k ${R}\033[38;5;54m$'\ue0b0'${R}"
  printf "\n"

  # slanted
  printf "  \033[1m3) slanted\033[0m "
  printf "%b" "${B1}${W} ~/project ${R}\033[38;5;4m${B2}$'\ue0b8'${R}${B2}${C} Sonnet 4.6 ${R}\033[38;5;17m${B3}$'\ue0b8'${R}${B3}${M} ↑1.2k ↓4.5k ${R}\033[38;5;54m$'\ue0b8'${R}"
  printf "\n"

  # bare
  printf "  \033[1m4) bare\033[0m    "
  printf "%b" "${B1}${W} ~/project ${R} ${B2}${C} Sonnet 4.6 ${R} ${B3}${M} ↑1.2k ↓4.5k ${R}"
  printf "\n\n"

  printf "Choice [1]: "
  local choice
  read -r choice
  choice="${choice:-1}"

  case "$choice" in
    2) WIZARD_SEPARATOR_STYLE="sharp" ;;
    3) WIZARD_SEPARATOR_STYLE="slanted" ;;
    4) WIZARD_SEPARATOR_STYLE="bare" ;;
    *) WIZARD_SEPARATOR_STYLE="round" ;;
  esac
}
