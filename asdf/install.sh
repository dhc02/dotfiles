#!/bin/sh
#
# asdf version manager

# Check for asdf
if test ! $(which asdf)
then
  echo "  Installing asdf for you."

  git clone "https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.6.0"

fi

exit 0
