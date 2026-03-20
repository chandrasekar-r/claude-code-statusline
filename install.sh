#!/usr/bin/env bash
# install.sh — one-liner bootstrap
#
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/chandrasekar-r/claude-code-statusline/main/install.sh)
#
# Or after cloning: ./install.sh

set -euo pipefail

REPO_URL="${CCS_REPO_URL:-https://github.com/chandrasekar-r/claude-code-statusline.git}"
INSTALL_DIR="${CCS_INSTALL_DIR:-${HOME}/.local/share/claude-statusline}"

_info()  { printf "\033[38;5;51m→\033[0m  %s\n" "$*"; }
_ok()    { printf "\033[38;5;46m✓\033[0m  %s\n" "$*"; }
_warn()  { printf "\033[38;5;214m⚠\033[0m  %s\n" "$*" >&2; }
_die()   { printf "\033[38;5;196m✗\033[0m  %s\n" "$*" >&2; exit 1; }

# ── 1. Check dependencies ─────────────────────────────────────────────────────
_check_deps() {
  local missing=()
  command -v git  &>/dev/null || missing+=(git)
  command -v jq   &>/dev/null || missing+=(jq)
  command -v bash &>/dev/null || missing+=(bash)

  if [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
    _die "bash 4.0+ required (you have $BASH_VERSION). On macOS: brew install bash"
  fi

  if [ "${#missing[@]}" -gt 0 ]; then
    _die "Missing dependencies: ${missing[*]}. Install with: brew install ${missing[*]}"
  fi
}

# ── 2. Clone or update ────────────────────────────────────────────────────────
_clone_or_update() {
  if [ -d "${INSTALL_DIR}/.git" ]; then
    _info "Updating existing installation at ${INSTALL_DIR}"
    git -C "$INSTALL_DIR" pull --ff-only
    _ok "Updated"
  else
    _info "Cloning to ${INSTALL_DIR}"
    git clone "$REPO_URL" "$INSTALL_DIR"
    _ok "Cloned"
  fi
}

# ── 3. If running from local clone (not from curl), skip clone ────────────────
_install_local() {
  INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  _info "Running from local clone: ${INSTALL_DIR}"
}

# ── Main ──────────────────────────────────────────────────────────────────────
main() {
  printf "\n\033[1m\033[38;5;51mClaude Code Statusline — Installer\033[0m\n"
  printf "\033[2m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m\n\n"

  _check_deps

  # Detect if running from a local clone
  local script_dir
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)" || script_dir=""
  if [ -f "${script_dir}/statusline.sh" ]; then
    INSTALL_DIR="$script_dir"
    _info "Using local clone at ${INSTALL_DIR}"
  else
    _clone_or_update
  fi

  chmod +x "${INSTALL_DIR}/statusline.sh" "${INSTALL_DIR}/configure.sh"

  export CCS_INSTALL_DIR="$INSTALL_DIR"

  _ok "Installation ready"
  printf "\nLaunching configuration wizard...\n\n"

  bash "${INSTALL_DIR}/configure.sh"
}

main "$@"
