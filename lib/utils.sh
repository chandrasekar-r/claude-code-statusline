#!/usr/bin/env bash
# lib/utils.sh — shared helper functions

# fmt_tokens: format a token count as human-readable (e.g. 1.2k, 3.4M)
fmt_tokens() {
  local n=$1
  if [ "$n" -ge 1000000 ] 2>/dev/null; then
    printf "%.1fM" "$(echo "scale=1; $n/1000000" | bc)"
  elif [ "$n" -ge 1000 ] 2>/dev/null; then
    printf "%.1fk" "$(echo "scale=1; $n/1000" | bc)"
  else
    printf "%s" "$n"
  fi
}

# ctx_bar: render a 10-char filled/empty bar for context window usage
ctx_bar() {
  local pct=$1
  local width="${CCS_TOKENS_BAR_WIDTH:-10}"
  local filled
  filled=$(echo "$pct * $width / 100" | bc 2>/dev/null || echo 0)
  local bar=""
  for ((i=0; i<width; i++)); do
    [ "$i" -lt "$filled" ] && bar="${bar}█" || bar="${bar}░"
  done
  printf "%s" "$bar"
}

# ctx_colour: return ANSI fg colour for a context usage percentage
ctx_colour() {
  local pct=$1
  [ -z "$pct" ] && { printf "%b" "$FG_WHITE"; return; }
  local ipct=${pct%.*}
  if   [ "$ipct" -ge 85 ]; then printf "%b" "$FG_RED"
  elif [ "$ipct" -ge 60 ]; then printf "%b" "$FG_ORANGE"
  elif [ "$ipct" -ge 35 ]; then printf "%b" "$FG_YELLOW"
  else                           printf "%b" "$FG_GREEN"
  fi
}

# shorten_path: trim a path to at most CCS_DIR_MAX_DEPTH components
shorten_path() {
  local cwd="$1"
  local max_depth="${CCS_DIR_MAX_DEPTH:-4}"
  local home_dir="$HOME"
  local short="${cwd/#$home_dir/~}"
  IFS='/' read -ra parts <<< "$short"
  if [ "${#parts[@]}" -gt "$max_depth" ]; then
    local trunc="${CCS_DIR_TRUNCATION_SYMBOL:-…}"
    short="${parts[0]}/${parts[1]}/${trunc}/${parts[-2]}/${parts[-1]}"
  fi
  printf "%s" "$short"
}
