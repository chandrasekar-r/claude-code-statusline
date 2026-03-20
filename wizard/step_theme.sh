#!/usr/bin/env bash
# wizard/step_theme.sh — step 3: color theme picker (scrollable, live inline preview)

wizard_step_theme() {
  local themes_dir="${CCS_INSTALL_DIR}/themes"
  local -a all_themes=()
  local f name
  for f in "${themes_dir}"/*.sh; do
    name="$(basename "$f" .sh)"
    all_themes+=("$name")
  done

  # Put flagship themes first, rest alphabetical
  local -a ordered=()
  local t i
  for t in neon minimal mono retro; do
    for i in "${!all_themes[@]}"; do
      if [ "${all_themes[$i]}" = "$t" ]; then
        ordered+=("$t")
        unset 'all_themes[$i]'
      fi
    done
  done
  all_themes=("${ordered[@]}" "${all_themes[@]}")

  # Non-TTY fallback
  if [ ! -t 0 ]; then
    WIZARD_THEME="neon"
    return 0
  fi

  # Descriptions — declare separately to avoid local+init failing under set -e
  declare -A _td
  _td[neon]="vivid neon — default"
  _td[minimal]="muted grays + pastels"
  _td[mono]="black & white"
  _td[retro]="amber-on-black"
  _td[carbon]="near-black + steel blue/lavender"
  _td[onyx]="dark grays + cyan-teal"
  _td[slate]="dark navy + lavender"
  _td[dusk]="very dark + rose/peach"
  _td[gunmetal]="descending grays + periwinkle"
  _td[midnight]="deep navy + lavender/blue"
  _td[obsidian]="near-black + vivid cyan"
  _td[mocha]="dark warm grays + mauve"
  _td[nord]="Nord polar night + frost blue"
  _td[catppuccin]="Catppuccin Mocha + sapphire"
  _td[pitch]="near-pure black, white hierarchy"
  _td[chalk]="near-black, bright white"
  _td[steel]="wide gray spread, fading"
  _td[warm-black]="near-black + warm gold"
  _td[tungsten]="dark grays, fading white"
  _td[paper-dark]="medium dark, gentle fade"
  _td[ashes]="ascending grays, whisper text"

  local sep=$'\ue0b4'
  local install_dir="${CCS_INSTALL_DIR}"

  _theme_preview() {
    local pf="${themes_dir}/${1}.sh"
    [ ! -f "$pf" ] && return 0
    # Spawn isolated subshell; suppress all errors; always exit 0
    bash -c "
      set -e
      source '${install_dir}/lib/ansi.sh'
      source '${pf}'
      R='\033[0m'
      printf '%b' \"\${BG_DIR}\${SEG_DIR_FG} ~/proj \${R}\"
      printf '%b' \"\033[38;5;\${BG_DIR_IDX}m\${BG_MODEL}${sep}\${R}\"
      printf '%b' \"\${BG_MODEL}\${SEG_MODEL_FG} ✦ Sonnet \${R}\"
      printf '%b' \"\033[38;5;\${BG_MODEL_IDX}m\${BG_TOKENS}${sep}\${R}\"
      printf '%b' \"\${BG_TOKENS}\${SEG_TOKENS_IN_FG} ↑1.6k \${SEG_TOKENS_OUT_FG}↓21k \${R}\"
      printf '%b' \"\033[38;5;\${BG_TOKENS_IDX}m\${BG_COST}${sep}\${R}\"
      printf '%b' \"\${BG_COST}\${SEG_COST_FG} \\\$0.79 \${SEG_TOTAL_FG}23k total \${R}\"
      printf '%b' \"\033[38;5;\${BG_COST_IDX}m${sep}\${R}\"
    " 2>/dev/null || true   # <-- always return 0 to parent
  }

  local cursor=0

  while true; do
    clear
    printf "\033[1m\033[38;5;51mClaude Code Statusline — Setup Wizard\033[0m\n"
    printf "\033[2m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m\n\n"
    printf "\033[1mStep 3 / 5 — Color theme\033[0m\n\n"
    printf "Use \033[1mk/j\033[0m or \033[1m↑/↓\033[0m to browse, \033[1mENTER\033[0m to select.\n\n"

    local idx=0
    for t in "${all_themes[@]}"; do
      if [ "$idx" -eq "$cursor" ]; then
        printf "  \033[48;5;236m▶ \033[1m%-14s\033[0m\033[48;5;236m  " "$t"
        _theme_preview "$t"
        printf "\033[0m\n"
      else
        printf "    \033[2m%-14s\033[0m  %s\n" "$t" "${_td[$t]:-}"
      fi
      idx=$(( idx + 1 ))   # use $(()) not (()) to avoid set -e exit on 0
    done

    printf "\n"
    IFS= read -r -s -n1 key
    if [ "$key" = $'\033' ]; then
      read -r -s -n2 -t 0.1 seq || true
      key="${key}${seq}"
    fi

    case "$key" in
      k|$'\033[A') [ "$cursor" -gt 0 ] && cursor=$(( cursor - 1 )) ;;
      j|$'\033[B') [ "$cursor" -lt $(( ${#all_themes[@]} - 1 )) ] && cursor=$(( cursor + 1 )) ;;
      ''|$'\n') break ;;
    esac
  done

  WIZARD_THEME="${all_themes[$cursor]}"
  unset _td
}
