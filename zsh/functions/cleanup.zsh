#!/usr/bin/env zsh

cleanup_remnants() {
  if [[ -f "$HOME/.zsh_history" ]]; then
    rm $HOME/.zsh_history
  fi
}

cleanup_remnants
