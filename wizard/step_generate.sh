#!/usr/bin/env bash
# wizard/step_generate.sh — step 5: write config + patch settings.json

wizard_step_generate() {
  clear
  printf "\033[1m\033[38;5;51mClaude Code Statusline — Setup Wizard\033[0m\n"
  printf "\033[2m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m\n\n"
  printf "\033[1mStep 5 / 5 — Summary\033[0m\n\n"
  printf "  Icon set:   \033[1m%s\033[0m\n" "$WIZARD_ICON_SET"
  printf "  Separators: \033[1m%s\033[0m\n" "$WIZARD_SEPARATOR_STYLE"
  printf "  Theme:      \033[1m%s\033[0m\n" "$WIZARD_THEME"
  printf "  Segments:   \033[1m%s\033[0m\n" "$WIZARD_SEGMENTS"
  printf "\n"

  local config_dir="${HOME}/.config/claude-statusline"
  local config_file="${config_dir}/config.sh"

  printf "Config will be written to: \033[38;5;51m%s\033[0m\n\n" "$config_file"
  printf "  \033[1m1)\033[0m Write config + patch Claude Code settings.json\n"
  printf "  \033[1m2)\033[0m Write config only (patch settings.json manually)\n"
  printf "  \033[1m3)\033[0m Abort — don't write anything\n\n"
  printf "Choice [1]: "

  local choice
  read -r choice
  choice="${choice:-1}"

  [ "$choice" = "3" ] && { printf "\nAborted.\n"; return 1; }

  # Write config
  mkdir -p "$config_dir"
  if [ -f "$config_file" ]; then
    local bak="${config_file}.bak.$(date +%s)"
    cp "$config_file" "$bak"
    printf "\nBacked up existing config to: %s\n" "$bak"
  fi

  cat > "$config_file" <<EOF
# Claude Code Statusline config — generated $(date)
# Re-run ./configure to change settings.
CCS_VERSION=1
CCS_ICON_SET="${WIZARD_ICON_SET}"
CCS_SEPARATOR_STYLE="${WIZARD_SEPARATOR_STYLE}"
CCS_THEME="${WIZARD_THEME}"
CCS_SEGMENTS="${WIZARD_SEGMENTS}"

# Segment options
CCS_DIR_MAX_DEPTH=4
CCS_DIR_TRUNCATION_SYMBOL="…"
CCS_GIT_SHOW_DIRTY=true
CCS_GIT_DIRTY_SYMBOL=" ✎"
CCS_MODEL_ICON="✦"
CCS_MODEL_SHOW_AGENT=true
CCS_TOKENS_SHOW_BAR=true
CCS_TOKENS_BAR_WIDTH=10
CCS_TOKENS_IN_SYMBOL="↑"
CCS_TOKENS_OUT_SYMBOL="↓"
CCS_CACHE_HIDE_IF_ZERO=true
CCS_COST_DECIMAL_PLACES=4
CCS_COST_HIDE_IF_ZERO=true
CCS_RATELIMIT_HIDE_IF_EMPTY=true
EOF

  printf "\n\033[38;5;46m✓\033[0m Config written to %s\n" "$config_file"

  if [ "$choice" = "1" ]; then
    _patch_settings_json
  else
    printf "\n\033[1mManual settings.json setup:\033[0m\n"
    printf "Add this to your Claude Code settings.json:\n\n"
    printf '  "statusCommand": "%s/statusline.sh"\n\n' "$CCS_INSTALL_DIR"
  fi
}

_patch_settings_json() {
  # Try common settings.json locations
  local settings_file=""
  local candidates=(
    "${HOME}/.claude/settings.json"
    "${HOME}/Library/Application Support/Claude/settings.json"
  )
  for f in "${candidates[@]}"; do
    [ -f "$f" ] && settings_file="$f" && break
  done

  local statusline_path="${CCS_INSTALL_DIR}/statusline.sh"

  if [ -z "$settings_file" ]; then
    # Create ~/.claude/settings.json
    settings_file="${HOME}/.claude/settings.json"
    mkdir -p "$(dirname "$settings_file")"
    printf '{\n  "statusCommand": "%s"\n}\n' "$statusline_path" > "$settings_file"
    printf "\033[38;5;46m✓\033[0m Created %s\n" "$settings_file"
    return
  fi

  # Check if jq is available for JSON patching
  if ! command -v jq &>/dev/null; then
    printf "\n\033[38;5;214m⚠\033[0m  jq not found — cannot auto-patch settings.json.\n"
    printf "Add manually: \"statusCommand\": \"%s\"\n" "$statusline_path"
    return
  fi

  # Patch with jq
  local tmp
  tmp="$(mktemp)"
  jq --arg cmd "$statusline_path" '. + {statusCommand: $cmd}' "$settings_file" > "$tmp"
  mv "$tmp" "$settings_file"
  printf "\033[38;5;46m✓\033[0m Patched %s\n" "$settings_file"
  printf "\nRestart Claude Code to apply changes.\n"
}
