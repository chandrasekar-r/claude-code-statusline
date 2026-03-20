#!/usr/bin/env bash
# themes/minimal.sh — muted grays + pastels

BG_DIR='\033[48;5;238m'    BG_DIR_IDX=238    # dark gray
BG_GIT='\033[48;5;240m'    BG_GIT_IDX=240    # medium gray
BG_MODEL='\033[48;5;236m'  BG_MODEL_IDX=236  # darker gray
BG_TOKENS='\033[48;5;237m' BG_TOKENS_IDX=237 # near-black gray
BG_COST='\033[48;5;235m'   BG_COST_IDX=235   # darkest gray

SEG_DIR_FG="$FG_WHITE"
SEG_GIT_FG="$FG_WHITE"
SEG_MODEL_FG='\033[38;5;153m'   # pastel blue
SEG_TOKENS_IN_FG='\033[38;5;183m'  # pastel purple
SEG_TOKENS_OUT_FG='\033[38;5;219m' # pastel pink
SEG_CACHE_FG='\033[38;5;159m'   # pastel cyan
SEG_CACHE_WRITE_FG='\033[38;5;183m'
SEG_COST_FG='\033[38;5;229m'    # pastel yellow
SEG_TOTAL_FG='\033[38;5;223m'   # pastel orange
SEG_RATE_FG='\033[38;5;229m'
SEG_VIM_NORMAL_FG='\033[38;5;153m'
SEG_VIM_INSERT_FG='\033[38;5;219m'
