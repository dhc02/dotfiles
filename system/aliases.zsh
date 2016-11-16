# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -FA --group-directories-first --color"
  alias l="gls -lAh --group-directories-first --color"
  alias lr="gls -FAt --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi
