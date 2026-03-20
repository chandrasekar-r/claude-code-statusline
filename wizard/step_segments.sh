#!/usr/bin/env bash
# wizard/step_segments.sh — step 4: segment multi-select + order

# All available segments in default order
_ALL_SEGMENTS=(dir git model vim_mode tokens cache cost rate_limits)
_SEGMENT_DESCRIPTIONS=(
  [dir]="Current working directory"
  [git]="Git branch and dirty indicator"
  [model]="Claude model name and agent"
  [vim_mode]="Vim mode badge (N/I/V)"
  [tokens]="Token counts and context bar"
  [cache]="Cache read/write indicators"
  [cost]="Session cost and total tokens"
  [rate_limits]="5h / 7d rate limit usage"
)

wizard_step_segments() {
  # Start with defaults enabled (vim_mode off by default)
  declare -A enabled
  for seg in "${_ALL_SEGMENTS[@]}"; do
    enabled[$seg]=true
  done
  enabled[vim_mode]=false

  # If WIZARD_SEGMENTS is already set (re-run), parse it
  if [ -n "${WIZARD_SEGMENTS:-}" ]; then
    for seg in "${_ALL_SEGMENTS[@]}"; do
      enabled[$seg]=false
    done
    for seg in $WIZARD_SEGMENTS; do
      enabled[$seg]=true
    done
  fi

  local cursor=0

  while true; do
    clear
    printf "\033[1m\033[38;5;51mClaude Code Statusline — Setup Wizard\033[0m\n"
    printf "\033[2m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m\n\n"
    printf "\033[1mStep 4 / 5 — Segments\033[0m\n\n"
    printf "Use \033[1mk/j\033[0m or \033[1m↑/↓\033[0m to navigate, \033[1mSPACE\033[0m to toggle, \033[1mENTER\033[0m to confirm.\n\n"

    local i=0
    for seg in "${_ALL_SEGMENTS[@]}"; do
      local check
      [ "${enabled[$seg]}" = "true" ] && check="\033[38;5;46m[✓]\033[0m" || check="\033[38;5;240m[ ]\033[0m"
      if [ "$i" -eq "$cursor" ]; then
        printf "  \033[48;5;236m▶ %b %-12s — %s\033[0m\n" "$check" "$seg" "${_SEGMENT_DESCRIPTIONS[$seg]:-}"
      else
        printf "    %b %-12s — %s\n" "$check" "$seg" "${_SEGMENT_DESCRIPTIONS[$seg]:-}"
      fi
      ((i++))
    done

    printf "\n"
    # Read a single key (no echo)
    IFS= read -r -s -n1 key
    # Handle escape sequences for arrow keys
    if [ "$key" = $'\033' ]; then
      read -r -s -n2 -t 0.1 seq
      key="${key}${seq}"
    fi

    case "$key" in
      k|$'\033[A')  # up
        [ "$cursor" -gt 0 ] && ((cursor--)) ;;
      j|$'\033[B')  # down
        [ "$cursor" -lt $(( ${#_ALL_SEGMENTS[@]} - 1 )) ] && ((cursor++)) ;;
      ' ')  # toggle
        local seg="${_ALL_SEGMENTS[$cursor]}"
        [ "${enabled[$seg]}" = "true" ] && enabled[$seg]=false || enabled[$seg]=true
        ;;
      ''|$'\n')  # enter
        break ;;
    esac
  done

  # Build ordered segment list (preserve _ALL_SEGMENTS order, only enabled)
  local result=""
  for seg in "${_ALL_SEGMENTS[@]}"; do
    [ "${enabled[$seg]}" = "true" ] && result="${result}${seg} "
  done
  WIZARD_SEGMENTS="${result% }"
}
