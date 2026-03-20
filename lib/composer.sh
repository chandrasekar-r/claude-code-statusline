#!/usr/bin/env bash
# lib/composer.sh — segment composition loop
#
# Owns all separator rendering. Each segment function must:
#   - Set SEGMENT_TEXT  : content string (with ANSI fg/bold, no bg applied)
#   - Set SEGMENT_BG    : full ANSI background escape (e.g. '\033[48;5;4m')
#   - Set SEGMENT_FG_NEXT : raw 256-colour index of this segment's bg (for sep colour)
#   - Return 0 to render, 1 to suppress

compose_segments() {
  local segments="$1"
  local out=""
  local prev_fg_next=""

  for seg in $segments; do
    SEGMENT_TEXT=""
    SEGMENT_BG=""
    SEGMENT_FG_NEXT=""

    # Call the segment function; skip if it returns non-zero
    "segment_${seg}" 2>/dev/null || continue

    # Guard: skip if segment didn't set required vars
    [ -z "$SEGMENT_BG" ] && continue

    if [ -n "$prev_fg_next" ]; then
      if [ "$prev_fg_next" != "$SEGMENT_FG_NEXT" ]; then
        # Different backgrounds: render visible hard separator
        out+="\033[38;5;${prev_fg_next}m${SEGMENT_BG}${SEP_HARD}${RST}"
      fi
      # Same background: emit nothing — the segment provides its own thin divider
    fi

    out+="${SEGMENT_BG}${SEGMENT_TEXT}"
    prev_fg_next="$SEGMENT_FG_NEXT"
  done

  # Trailing end cap: last segment's bg colour as fg, terminal bg reset
  if [ -n "$prev_fg_next" ]; then
    out+="\033[38;5;${prev_fg_next}m${BG_RESET}${SEP_END}${RST}"
  fi

  CCS_OUTPUT="$out"
}
