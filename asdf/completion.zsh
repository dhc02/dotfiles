#source $HOME/.asdf/completions/asdf.bash
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit