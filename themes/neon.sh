#!/usr/bin/env bash
# themes/neon.sh — vivid neon palette (default; matches p10k rainbow style)

# Segment backgrounds
BG_DIR='\033[48;5;4m'      BG_DIR_IDX=4      # blue    — dir / git
BG_GIT='\033[48;5;2m'      BG_GIT_IDX=2      # green   — clean git
BG_MODEL='\033[48;5;17m'   BG_MODEL_IDX=17   # deep navy — model
BG_TOKENS='\033[48;5;54m'  BG_TOKENS_IDX=54  # deep purple — tokens / cache
BG_COST='\033[48;5;22m'    BG_COST_IDX=22    # deep green — cost / rate limits

# Segment foregrounds
SEG_DIR_FG="$FG_WHITE"
SEG_GIT_FG="$FG_BLACK"
SEG_MODEL_FG="$FG_CYAN"
SEG_TOKENS_IN_FG="$FG_MAGENTA"
SEG_TOKENS_OUT_FG="$FG_PINK"
SEG_CACHE_FG="$FG_TEAL"
SEG_CACHE_WRITE_FG="$FG_PURPLE"
SEG_COST_FG="$FG_YELLOW"
SEG_TOTAL_FG="$FG_ORANGE"
SEG_RATE_FG="$FG_YELLOW"
SEG_VIM_NORMAL_FG="$FG_CYAN"
SEG_VIM_INSERT_FG="$FG_MAGENTA"
