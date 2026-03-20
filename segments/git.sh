#!/usr/bin/env bash
# segments/git.sh — git branch + dirty indicator

segment_git() {
  local cwd="${CCS_J_CWD}"
  local git_branch=""
  local git_raw

  # Prefer worktree branch from JSON (set by Claude Code for worktrees)
  if [ -n "${CCS_J_WT_BRANCH}" ]; then
    git_branch="${CCS_J_WT_BRANCH}"
  elif git_raw=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null); then
    git_branch="$git_raw"
  elif git_raw=$(git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null); then
    git_branch="detached:$git_raw"
  fi

  [ -z "$git_branch" ] && return 1

  local git_dirty=""
  if [ "${CCS_GIT_SHOW_DIRTY:-true}" = "true" ]; then
    if ! git -C "$cwd" --no-optional-locks diff --quiet 2>/dev/null || \
       ! git -C "$cwd" --no-optional-locks diff --cached --quiet 2>/dev/null; then
      git_dirty="${CCS_GIT_DIRTY_SYMBOL:- ✎}"
    fi
  fi

  SEGMENT_TEXT=" ${BOLD}${SEG_GIT_FG} ${ICON_BRANCH} ${git_branch}${git_dirty} ${RST}"
  SEGMENT_BG="$BG_GIT"
  SEGMENT_FG_NEXT="$BG_GIT_IDX"
  return 0
}
