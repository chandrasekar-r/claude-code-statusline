#!/usr/bin/env bash
# configure.sh — interactive setup wizard (p10k-style)
#
# Usage: ./configure
# Re-run at any time to change settings.

set -euo pipefail

CCS_INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export CCS_INSTALL_DIR

# Load wizard steps
source "${CCS_INSTALL_DIR}/wizard/step_font.sh"
source "${CCS_INSTALL_DIR}/wizard/step_separators.sh"
source "${CCS_INSTALL_DIR}/wizard/step_theme.sh"
source "${CCS_INSTALL_DIR}/wizard/step_segments.sh"
source "${CCS_INSTALL_DIR}/wizard/step_generate.sh"

# Wizard state
WIZARD_ICON_SET=""
WIZARD_SEPARATOR_STYLE=""
WIZARD_THEME=""
WIZARD_SEGMENTS=""

main() {
  # Check bash version
  if [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
    printf "Error: bash 4.0+ required (you have %s)\n" "$BASH_VERSION" >&2
    exit 1
  fi

  wizard_step_font
  wizard_step_separators
  wizard_step_theme
  wizard_step_segments
  wizard_step_generate || exit 0

  printf "\n\033[1m\033[38;5;46mSetup complete!\033[0m\n\n"
}

main "$@"
