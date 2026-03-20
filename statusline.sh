#!/usr/bin/env bash
# statusline.sh — Claude Code statusline entrypoint
#
# Claude Code's settings.json should point here:
#   "statusCommand": "/path/to/statusline.sh"
#
# Config is loaded from ~/.config/claude-statusline/config.sh
# (or $CCS_CONFIG_PATH). Run ./configure to set up.

set -euo pipefail

# ── 1. Read stdin ─────────────────────────────────────────────────────────────
CCS_INPUT="$(cat)"

# ── 2. Resolve script directory ───────────────────────────────────────────────
CCS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── 3. Source lib files ───────────────────────────────────────────────────────
# shellcheck source=lib/ansi.sh
source "${CCS_DIR}/lib/ansi.sh"

# ── 4. Source config ──────────────────────────────────────────────────────────
CCS_CONFIG_PATH="${CCS_CONFIG_PATH:-${HOME}/.config/claude-statusline/config.sh}"
if [ -f "$CCS_CONFIG_PATH" ]; then
  # shellcheck source=/dev/null
  source "$CCS_CONFIG_PATH"
else
  # Defaults (used before first configure run)
  CCS_ICON_SET="${CCS_ICON_SET:-nerd3}"
  CCS_SEPARATOR_STYLE="${CCS_SEPARATOR_STYLE:-round}"
  CCS_THEME="${CCS_THEME:-neon}"
  CCS_SEGMENTS="${CCS_SEGMENTS:-dir git model tokens cache cost rate_limits}"
fi

# ── 5. Source remaining lib files (depend on config vars) ─────────────────────
# shellcheck source=lib/icons.sh
source "${CCS_DIR}/lib/icons.sh"
# shellcheck source=lib/separators.sh
source "${CCS_DIR}/lib/separators.sh"
# shellcheck source=lib/utils.sh
source "${CCS_DIR}/lib/utils.sh"

# ── 6. Source theme ───────────────────────────────────────────────────────────
THEME="${CCS_THEME:-neon}"
THEME_FILE="${CCS_DIR}/themes/${THEME}.sh"
if [ -f "$THEME_FILE" ]; then
  # shellcheck source=/dev/null
  source "$THEME_FILE"
else
  source "${CCS_DIR}/themes/neon.sh"
fi

# Apply any custom theme colour overrides
if [ "${CCS_THEME}" = "custom" ]; then
  [ -n "${CCS_COLOR_BG_DIR:-}"    ] && BG_DIR="$CCS_COLOR_BG_DIR"    && BG_DIR_IDX="${CCS_COLOR_BG_DIR_RAW:-4}"
  [ -n "${CCS_COLOR_BG_GIT:-}"    ] && BG_GIT="$CCS_COLOR_BG_GIT"    && BG_GIT_IDX="${CCS_COLOR_BG_GIT_RAW:-2}"
  [ -n "${CCS_COLOR_BG_MODEL:-}"  ] && BG_MODEL="$CCS_COLOR_BG_MODEL" && BG_MODEL_IDX="${CCS_COLOR_BG_MODEL_RAW:-17}"
  [ -n "${CCS_COLOR_BG_TOKENS:-}" ] && BG_TOKENS="$CCS_COLOR_BG_TOKENS" && BG_TOKENS_IDX="${CCS_COLOR_BG_TOKENS_RAW:-54}"
  [ -n "${CCS_COLOR_BG_COST:-}"   ] && BG_COST="$CCS_COLOR_BG_COST"  && BG_COST_IDX="${CCS_COLOR_BG_COST_RAW:-22}"
fi

# ── 7. Single jq call: batch-parse all JSON fields ───────────────────────────
# Using eval + @sh reduces 14+ subshell forks to 1.
eval "$(printf '%s' "$CCS_INPUT" | jq -r '
  "CCS_J_MODEL="    + (.model.display_name // "Claude" | @sh),
  "CCS_J_CWD="      + (.cwd // .workspace.current_dir // "" | @sh),
  "CCS_J_SESSION="  + (.session_name // "" | @sh),
  "CCS_J_VIM_MODE=" + (.vim.mode // "" | @sh),
  "CCS_J_AGENT="    + (.agent.name // "" | @sh),
  "CCS_J_WT_BRANCH="+ (.worktree.branch // "" | @sh),
  "CCS_J_TOTAL_IN=" + (.context_window.total_input_tokens // 0 | tostring | @sh),
  "CCS_J_TOTAL_OUT="+ (.context_window.total_output_tokens // 0 | tostring | @sh),
  "CCS_J_USED_PCT=" + (.context_window.used_percentage // "" | tostring | @sh),
  "CCS_J_CACHE_READ="  + (.context_window.current_usage.cache_read_input_tokens // 0 | tostring | @sh),
  "CCS_J_CACHE_WRITE=" + (.context_window.current_usage.cache_creation_input_tokens // 0 | tostring | @sh),
  "CCS_J_COST="     + (.cost.total_cost_usd // "" | tostring | @sh),
  "CCS_J_FIVE_H="   + (.rate_limits.five_hour.used_percentage // "" | tostring | @sh),
  "CCS_J_SEVEN_D="  + (.rate_limits.seven_day.used_percentage // "" | tostring | @sh)
')"

# ── 8. Source segment files ───────────────────────────────────────────────────
for _seg in $CCS_SEGMENTS; do
  _seg_file="${CCS_DIR}/segments/${_seg}.sh"
  [ -f "$_seg_file" ] && source "$_seg_file"
done
unset _seg _seg_file

# ── 9. Source composer + render ───────────────────────────────────────────────
# shellcheck source=lib/composer.sh
source "${CCS_DIR}/lib/composer.sh"
compose_segments "$CCS_SEGMENTS"

printf "%b" "$CCS_OUTPUT"
