# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.

#####
# Actually, don't do this because it requires typing a password into the command prompt and we'd like to be able to run dot headless once per day.
#####
# echo "› sudo softwareupdate -i -a"
# sudo softwareupdate -i -a
