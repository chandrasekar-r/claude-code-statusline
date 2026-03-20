#!/usr/bin/env bash
# themes/mono.sh — black and white only

BG_DIR='\033[48;5;240m'    BG_DIR_IDX=240    # dark gray
BG_GIT='\033[48;5;244m'    BG_GIT_IDX=244    # medium gray
BG_MODEL='\033[48;5;236m'  BG_MODEL_IDX=236  # darker gray
BG_TOKENS='\033[48;5;238m' BG_TOKENS_IDX=238 # dark gray
BG_COST='\033[48;5;234m'   BG_COST_IDX=234   # near-black

SEG_DIR_FG="$FG_WHITE"
SEG_GIT_FG="$FG_BLACK"
SEG_MODEL_FG="$FG_WHITE"
SEG_TOKENS_IN_FG="$FG_WHITE"
SEG_TOKENS_OUT_FG='\033[38;5;245m'  # light gray
SEG_CACHE_FG='\033[38;5;248m'       # lighter gray
SEG_CACHE_WRITE_FG='\033[38;5;242m' # mid gray
SEG_COST_FG="$FG_WHITE"
SEG_TOTAL_FG='\033[38;5;248m'
SEG_RATE_FG='\033[38;5;245m'
SEG_VIM_NORMAL_FG="$FG_WHITE"
SEG_VIM_INSERT_FG='\033[38;5;248m'
