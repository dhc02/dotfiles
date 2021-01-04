#!/bin/sh
#
# asdf version manager

# Check for asdf
if test ! $(which rustc)
then
  echo "--------------"
  echo "Installing Rust"
  echo "--------------"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

fi

exit 0

