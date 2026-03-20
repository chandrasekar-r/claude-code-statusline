#!/usr/bin/env bash
# wizard/step_theme.sh — step 3: color theme picker (scrollable, live inline preview)

wizard_step_theme() {
  # Discover available themes from the themes/ directory
  local themes_dir="${CCS_INSTALL_DIR}/themes"
  local -a all_themes=()
  for f in "${themes_dir}"/*.sh; do
    local name
    name="$(basename "$f" .sh)"
    all_themes+=("$name")
  done
  # Sort alphabetically but put the flagships first
  local -a ordered=()
  for t in neon minimal mono retro; do
    for i in "${!all_themes[@]}"; do
      [ "${all_themes[$i]}" = "$t" ] && ordered+=("$t") && unset 'all_themes[$i]'
    done
  done
  all_themes=("${ordered[@]}" "${all_themes[@]}")

  # Non-TTY fallback
  if [ ! -t 0 ]; then
    WIZARD_THEME="neon"
    return 0
  fi

  local cursor=0
  local -A descriptions=(
    [neon]="vivid neon — default"
    [minimal]="muted grays + pastels"
    [mono]="black & white"
    [retro]="amber-on-black"
    [carbon]="near-black + steel blue/lavender"
    [onyx]="dark grays + cyan-teal"
    [slate]="dark navy + lavender"
    [dusk]="very dark + rose/peach"
    [gunmetal]="descending grays + periwinkle"
    [midnight]="deep navy + lavender/blue"
    [obsidian]="near-black + vivid cyan"
    [mocha]="dark warm grays + mauve"
    [nord]="Nord polar night + frost blue"
    [catppuccin]="Catppuccin Mocha + sapphire"
    [pitch]="near-pure black, white hierarchy"
    [chalk]="near-black, bright white"
    [steel]="wide gray spread, fading"
    [warm-black]="near-black + warm gold"
    [tungsten]="dark grays, fading white"
    [paper-dark]="medium dark, gentle fade"
    [ashes]="ascending grays, whisper text"
  )

  # Build a one-line ANSI preview for a theme by sourcing it
  _theme_preview() {
    local t="$1"
    local f="${themes_dir}/${t}.sh"
    [ ! -f "$f" ] && printf "(no preview)" && return
    local sep=$'\ue0b4'
    # Source into a subshell to avoid polluting our env
    bash -c "
      source '${CCS_INSTALL_DIR}/lib/ansi.sh'
      source '$f'
      R='\033[0m'
      printf '%b' \"\${BG_DIR}\${SEG_DIR_FG} ~/proj \${R}\"
      printf '%b' \"\033[38;5;\${BG_DIR_IDX}m\${BG_MODEL}${sep}\${R}\"
      printf '%b' \"\${BG_MODEL}\${SEG_MODEL_FG} ✦ Sonnet \${R}\"
      printf '%b' \"\033[38;5;\${BG_MODEL_IDX}m\${BG_TOKENS}${sep}\${R}\"
      printf '%b' \"\${BG_TOKENS}\${SEG_TOKENS_IN_FG} ↑1.6k \${SEG_TOKENS_OUT_FG}↓21k \${R}\"
      printf '%b' \"\033[38;5;\${BG_TOKENS_IDX}m\${BG_COST}${sep}\${R}\"
      printf '%b' \"\${BG_COST}\${SEG_COST_FG} \\\$0.79 \${SEG_TOTAL_FG}23k total \${R}\"
      printf '%b' \"\033[38;5;\${BG_COST_IDX}m${sep}\${R}\"
    " 2>/dev/null
  }

  while true; do
    clear
    printf "\033[1m\033[38;5;51mClaude Code Statusline — Setup Wizard\033[0m\n"
    printf "\033[2m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m\n\n"
    printf "\033[1mStep 3 / 5 — Color theme\033[0m\n\n"
    printf "Use \033[1mk/j\033[0m or \033[1m↑/↓\033[0m to browse, \033[1mENTER\033[0m to select.\n\n"

    local i=0
    for t in "${all_themes[@]}"; do
      local desc="${descriptions[$t]:-}"
      if [ "$i" -eq "$cursor" ]; then
        printf "  \033[48;5;236m▶ \033[1m%-14s\033[0m\033[48;5;236m  " "$t"
        _theme_preview "$t"
        printf "\033[0m\n"
      else
        printf "    \033[2m%-14s\033[0m  %s\n" "$t" "$desc"
      fi
      ((i++))
    done

    printf "\n"
    IFS= read -r -s -n1 key
    if [ "$key" = $'\033' ]; then
      read -r -s -n2 -t 0.1 seq
      key="${key}${seq}"
    fi

    case "$key" in
      k|$'\033[A') [ "$cursor" -gt 0 ] && ((cursor--)) ;;
      j|$'\033[B') [ "$cursor" -lt $(( ${#all_themes[@]} - 1 )) ] && ((cursor++)) ;;
      ''|$'\n') break ;;
    esac
  done

  WIZARD_THEME="${all_themes[$cursor]}"
}
