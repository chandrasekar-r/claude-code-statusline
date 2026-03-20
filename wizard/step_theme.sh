#!/usr/bin/env bash
# wizard/step_theme.sh — step 3: color theme with live preview

wizard_step_theme() {
  clear
  printf "\033[1m\033[38;5;51mClaude Code Statusline — Setup Wizard\033[0m\n"
  printf "\033[2m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m\n\n"
  printf "\033[1mStep 3 / 5 — Color theme\033[0m\n\n"
  printf "Choose a color theme:\n\n"

  local R='\033[0m'
  local SEP=$'\ue0b4'

  # neon
  printf "  \033[1m1) neon\033[0m    (vivid — default)\n     "
  printf "%b" "\033[48;5;4m\033[38;5;255m ~/proj \033[0m\033[38;5;4m\033[48;5;17m${SEP}\033[0m\033[48;5;17m\033[38;5;51m ✦ Sonnet \033[0m\033[38;5;17m\033[48;5;54m${SEP}\033[0m\033[48;5;54m\033[38;5;201m ↑1.2k \033[0m\033[38;5;54m\033[48;5;22m${SEP}\033[0m\033[48;5;22m\033[38;5;214m \$0.0012 \033[0m\033[38;5;22m${SEP}\033[0m"
  printf "\n\n"

  # minimal
  printf "  \033[1m2) minimal\033[0m (muted grays)\n     "
  printf "%b" "\033[48;5;238m\033[38;5;255m ~/proj \033[0m\033[38;5;238m\033[48;5;236m${SEP}\033[0m\033[48;5;236m\033[38;5;153m ✦ Sonnet \033[0m\033[38;5;236m\033[48;5;237m${SEP}\033[0m\033[48;5;237m\033[38;5;183m ↑1.2k \033[0m\033[38;5;237m\033[48;5;235m${SEP}\033[0m\033[48;5;235m\033[38;5;229m \$0.0012 \033[0m\033[38;5;235m${SEP}\033[0m"
  printf "\n\n"

  # mono
  printf "  \033[1m3) mono\033[0m    (black & white)\n     "
  printf "%b" "\033[48;5;240m\033[38;5;255m ~/proj \033[0m\033[38;5;240m\033[48;5;236m${SEP}\033[0m\033[48;5;236m\033[38;5;255m ✦ Sonnet \033[0m\033[38;5;236m\033[48;5;238m${SEP}\033[0m\033[48;5;238m\033[38;5;255m ↑1.2k \033[0m\033[38;5;238m\033[48;5;234m${SEP}\033[0m\033[48;5;234m\033[38;5;255m \$0.0012 \033[0m\033[38;5;234m${SEP}\033[0m"
  printf "\n\n"

  # retro
  printf "  \033[1m4) retro\033[0m   (amber-on-black)\n     "
  printf "%b" "\033[48;5;94m\033[38;5;214m ~/proj \033[0m\033[38;5;94m\033[48;5;58m${SEP}\033[0m\033[48;5;58m\033[38;5;214m ✦ Sonnet \033[0m\033[38;5;58m\033[48;5;52m${SEP}\033[0m\033[48;5;52m\033[38;5;208m ↑1.2k \033[0m\033[38;5;52m\033[48;5;22m${SEP}\033[0m\033[48;5;22m\033[38;5;148m \$0.0012 \033[0m\033[38;5;22m${SEP}\033[0m"
  printf "\n\n"

  printf "Choice [1]: "
  local choice
  read -r choice
  choice="${choice:-1}"

  case "$choice" in
    2) WIZARD_THEME="minimal" ;;
    3) WIZARD_THEME="mono" ;;
    4) WIZARD_THEME="retro" ;;
    *) WIZARD_THEME="neon" ;;
  esac
}
