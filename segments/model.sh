#!/usr/bin/env bash
# segments/model.sh — model name + optional agent name

segment_model() {
  local model_label="${CCS_J_MODEL}"
  [ -z "$model_label" ] && model_label="Claude"

  if [ "${CCS_MODEL_SHOW_AGENT:-true}" = "true" ] && [ -n "${CCS_J_AGENT}" ]; then
    model_label="${model_label} ⚙ ${CCS_J_AGENT}"
  fi

  SEGMENT_BG="$BG_MODEL"
  SEGMENT_TEXT=" ${BOLD}${SEG_MODEL_FG}${ICON_MODEL} ${model_label}${RST}${BG_MODEL} "
  SEGMENT_FG_NEXT="$BG_MODEL_IDX"
  return 0
}
