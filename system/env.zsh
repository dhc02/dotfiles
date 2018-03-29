export EDITOR='code'

# by default, search through command history with whatever has been
# typed at the prompt so far when the up and down keys are pressed

bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

export XCODE="`xcode-select --print-path`"