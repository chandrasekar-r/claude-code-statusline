#!/usr/bin/env bash
# lib/ansi.sh — ANSI escape helpers

RST='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'

# Foregrounds (256-colour)
FG_BLACK='\033[38;5;232m'
FG_WHITE='\033[38;5;255m'
FG_CYAN='\033[38;5;51m'
FG_MAGENTA='\033[38;5;201m'
FG_ORANGE='\033[38;5;214m'
FG_YELLOW='\033[38;5;226m'
FG_GREEN='\033[38;5;46m'
FG_RED='\033[38;5;196m'
FG_PINK='\033[38;5;213m'
FG_TEAL='\033[38;5;87m'
FG_PURPLE='\033[38;5;141m'

BG_RESET='\033[49m'
