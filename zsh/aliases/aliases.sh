#!/usr/bin/env bash

# +----+
# | ls |
# +----+
alias ls='ls --color=auto'
alias l='ls -l'
alias ll='ls -lahF'
alias lls='ls -lahFtr'
alias la='ls -A'
alias lc='ls -CF'

# +--------+
# | vscode |
# +--------+
alias code="code-insiders"

# +----------------------+
# | directory navication |
# +----------------------+
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index