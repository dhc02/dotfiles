export EDITOR='code'
# This sets the editor for the "fc" shell command, which opens the last command in an editor and doesn't execute it until that editor saves the file. Works better and faster with a shell-based editor, so nano.
export FCEDIT='nano'

# by default, search through command history with whatever has been
# typed at the prompt so far when the up and down keys are pressed

bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

export XCODE="`xcode-select --print-path`"