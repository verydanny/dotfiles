export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

# +-----+
# | FNM |
# +-----+
FNM_PATH="$XDG_CONFIG_HOME/local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$XDG_CONFIG_HOME/local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd --fnm-dir $XDG_CONFIG_HOME/local/share/fnm)"
  echo "FNM WORKING"
fi
