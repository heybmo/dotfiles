#!/usr/bin/env zsh
# Utility functions for use across all other namespaces.
# DO NOT IMPORT ANY OTHER MODULES HERE.
#
# Following from nvm repo:
# "local" warning, quote expansion warning, sed warning, `local` warning
# shellcheck disable=SC2039,SC2016,SC2001,SC3043

is_zsh() {
  [ -n "${ZSH_VERSION-}" ]
}

shellconf_echo() {
  command printf %s\\n "$*" 2>/dev/null;
}

shellconf_dir() {
  echo "${HOME}/shellconf"
}

ensure_installed() {
  if ! command -v "$1" &> /dev/null; then
    shellconf_echo "Tool $1 is not installed!";
  fi
}
