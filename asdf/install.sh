#!/bin/sh
#
# asdf version manager

# Check for asdf
if test ! $(which asdf)
then
  echo "  Installing asdf for you."

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
  cd $ZSH

fi

exit 0

# update asdf and plugins
asdf update
asdf plugin-update -all
