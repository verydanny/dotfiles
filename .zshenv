export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export HISTSIZE=10000                      # Maximum events for internal history
export SAVEHIST=10000                      # Maximum events in history file
export HISTFILE="$ZDOTDIR/.zsh_history"    # History filepath
