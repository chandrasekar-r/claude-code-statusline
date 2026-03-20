#!/usr/bin/env bash
# wizard/step_font.sh — step 1: detect font/icon capability

wizard_step_font() {
  clear
  printf "\033[1m\033[38;5;51mClaude Code Statusline — Setup Wizard\033[0m\n"
  printf "\033[2m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m\n\n"
  printf "\033[1mStep 1 / 5 — Icon set\033[0m\n\n"
  printf "This statusline uses special icons from Nerd Fonts.\n"
  printf "Look at the character below — does it look like a solid diamond ◆ ?\n\n"
  printf "  Test character:  \033[1m\033[38;5;51m\ue0b4\033[0m  (should be a rounded arrow/chevron)\n"
  printf "  Bonus icon test: \033[1m\033[38;5;201m\uf126\033[0m  (should be a git branch icon)\n\n"
  printf "If these look like squares, boxes, or question marks, choose unicode or ascii.\n\n"
  printf "  \033[1m1)\033[0m Nerd Fonts v3  — full icons (◆ renders, branch icon renders)\n"
  printf "  \033[1m2)\033[0m Unicode only   — basic symbols (⎇ ⚡ ✎) no Nerd Font required\n"
  printf "  \033[1m3)\033[0m ASCII only     — no special characters at all\n\n"
  printf "Choice [1]: "

  local choice
  read -r choice
  choice="${choice:-1}"

  case "$choice" in
    2) WIZARD_ICON_SET="unicode" ;;
    3) WIZARD_ICON_SET="ascii" ;;
    *) WIZARD_ICON_SET="nerd3" ;;
  esac
}
