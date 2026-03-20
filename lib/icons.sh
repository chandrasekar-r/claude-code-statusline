#!/usr/bin/env bash
# lib/icons.sh — icon sets: nerd3 | unicode | ascii
# Sourced after config is loaded; CCS_ICON_SET must already be set.

case "${CCS_ICON_SET:-nerd3}" in
  nerd3)
    ICON_BRANCH=$'\uf126'      #
    ICON_CACHE_READ='󰆦'        # U+F0196 nf-md-cached
    ICON_CACHE_WRITE='󰐒'       # U+F0412 nf-md-pencil_plus
    ICON_TOTAL='󱈸'             # U+F04F8 nf-md-sigma
    ICON_MODEL="${CCS_MODEL_ICON:-✦}"
    ;;
  unicode)
    ICON_BRANCH='⎇'
    ICON_CACHE_READ='⚡'
    ICON_CACHE_WRITE='✎'
    ICON_TOTAL='Σ'
    ICON_MODEL="${CCS_MODEL_ICON:-◆}"
    ;;
  ascii)
    ICON_BRANCH='>'
    ICON_CACHE_READ='C'
    ICON_CACHE_WRITE='W'
    ICON_TOTAL='T'
    ICON_MODEL="${CCS_MODEL_ICON:-*}"
    ;;
esac
