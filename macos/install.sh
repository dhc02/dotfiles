
echo "Configuring General System UI/UX..."
###############################################################################
# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
echo "closing any system preferences to prevent issues with automated changes"
osascript -e 'tell application "System Preferences" to quit'


##############################################################################
# Security                                                                   #
##############################################################################
# Based on:
# https://github.com/drduh/macOS-Security-and-Privacy-Guide
# https://benchmarks.cisecurity.org/tools2/osx/CIS_Apple_OSX_10.12_Benchmark_v1.0.0.pdf

# Enable firewall. Possible values:
#   0 = off
#   1 = on for specific sevices
#   2 = on for essential services
# sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Enable firewall stealth mode (no response to ICMP / ping requests)
# Source: https://support.apple.com/kb/PH18642
#sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1
# sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1

# Enable firewall logging
#sudo defaults write /Library/Preferences/com.apple.alf loggingenabled -int 1

# Do not automatically allow signed software to receive incoming connections
#sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool false

# Log firewall events for 90 days
#sudo perl -p -i -e 's/rotate=seq compress file_max=5M all_max=50M/rotate=utc compress file_max=5M ttl=90/g' "/etc/asl.conf"
#sudo perl -p -i -e 's/appfirewall.log file_max=5M all_max=50M/appfirewall.log rotate=utc compress file_max=5M ttl=90/g' "/etc/asl.conf"

# Reload the firewall
# (uncomment if above is not commented out)
#launchctl unload /System/Library/LaunchAgents/com.apple.alf.useragent.plist
#sudo launchctl unload /System/Library/LaunchDaemons/com.apple.alf.agent.plist
#sudo launchctl load /System/Library/LaunchDaemons/com.apple.alf.agent.plist
#launchctl load /System/Library/LaunchAgents/com.apple.alf.useragent.plist

# Disable IR remote control
#sudo defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -bool false

# Turn Bluetooth off completely
#sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0
#sudo launchctl unload /System/Library/LaunchDaemons/com.apple.blued.plist
#sudo launchctl load /System/Library/LaunchDaemons/com.apple.blued.plist

# Disable wifi captive portal
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

# Disable remote apple events
# sudo systemsetup -setremoteappleevents off

# Disable remote login
# sudo systemsetup -setremotelogin off

# Disable wake-on modem
# sudo systemsetup -setwakeonmodem off

# Disable wake-on LAN
# sudo systemsetup -setwakeonnetworkaccess off

# Disable file-sharing via AFP or SMB
# sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist
# sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist

# Display login window as name and password
#sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true

# Do not show password hints
#sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0

# Disable guest account login
# sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

# Automatically lock the login keychain for inactivity after 6 hours
#security set-keychain-settings -t 21600 -l ~/Library/Keychains/login.keychain

# Destroy FileVault key when going into standby mode, forcing a re-auth.
# Source: https://web.archive.org/web/20160114141929/http://training.apple.com/pdf/WP_FileVault2.pdf
# sudo pmset destroyfvkeyonstandby 1

# Disable Bonjour multicast advertisements
# sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true

# Disable the crash reporter
#defaults write com.apple.CrashReporter DialogType -string "none"

# Disable diagnostic reports
#sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.SubmitDiagInfo.plist

# Log authentication events for 90 days
#sudo perl -p -i -e 's/rotate=seq file_max=5M all_max=20M/rotate=utc file_max=5M ttl=90/g' "/etc/asl/com.apple.authd"

# Log installation events for a year
#sudo perl -p -i -e 's/format=bsd/format=bsd mode=0640 rotate=utc compress file_max=5M ttl=365/g' "/etc/asl/com.apple.install"

# Increase the retention time for system.log and secure.log
#sudo perl -p -i -e 's/\/var\/log\/wtmp.*$/\/var\/log\/wtmp   \t\t\t640\ \ 31\    *\t\@hh24\ \J/g' "/etc/newsyslog.conf"

# Keep a log of kernel events for 30 days
#sudo perl -p -i -e 's|flags:lo,aa|flags:lo,aa,ad,fd,fm,-all,^-fa,^-fc,^-cl|g' /private/etc/security/audit_control
#sudo perl -p -i -e 's|filesz:2M|filesz:10M|g' /private/etc/security/audit_control
#sudo perl -p -i -e 's|expire-after:10M|expire-after: 30d |g' /private/etc/security/audit_control

# # Disable the “Are you sure you want to open this application?” dialog
# defaults write com.apple.LaunchServices LSQuarantine -bool false

###############################################################################
# SSD-specific tweaks                                                         #
###############################################################################

# running "Disable local Time Machine snapshots"
# sudo tmutil disablelocal

# running "Disable hibernation (speeds up entering sleep mode)"
# sudo pmset -a hibernatemode 0

# running "Remove the sleep image file to save disk space"
# sudo rm -rf /Private/var/vm/sleepimage
# running "Create a zero-byte file instead"
# sudo touch /Private/var/vm/sleepimage
# running "…and make sure it can’t be rewritten"
# sudo chflags uchg /Private/var/vm/sleepimage

#running "Disable the sudden motion sensor as it’s not useful for SSDs"
# sudo pmset -a sms 0

################################################
# Optional / Experimental                      #
################################################

# running "Set computer name (as done via System Preferences → Sharing)"
# sudo scutil --set ComputerName "antic"
# sudo scutil --set HostName "antic"
# sudo scutil --set LocalHostName "antic"
# sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "antic"

# running "Disable smooth scrolling"
# (Uncomment if you’re on an older Mac that messes up the animation)
# defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# running "Disable Resume system-wide"
# defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false
# TODO: might want to enable this again and set specific apps that this works great for
# e.g. defaults write com.microsoft.word NSQuitAlwaysKeepsWindows -bool true

# running "Fix for the ancient UTF-8 bug in QuickLook (http://mths.be/bbo)""
# # Commented out, as this is known to cause problems in various Adobe apps :(
# # See https://github.com/mathiasbynens/dotfiles/issues/237
# echo "0x08000100:0" > ~/.CFUserTextEncoding

# running "Stop iTunes from responding to the keyboard media keys"
# launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

# running "Show icons for hard drives, servers, and removable media on the desktop"
# defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
# defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
# defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
# defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# running "Enable the MacBook Air SuperDrive on any Mac"
# sudo nvram boot-args="mbasd=1"

# running "Remove Dropbox’s green checkmark icons in Finder"
# file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
# [ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# running "Wipe all (default) app icons from the Dock"
# # This is only really useful when setting up a new Mac, or if you don’t use
# # the Dock to launch apps.
# defaults write com.apple.dock persistent-apps -array ""

#running "Enable the 2D Dock"
#defaults write com.apple.dock no-glass -bool true

#running "Disable the Launchpad gesture (pinch with thumb and three fingers)"
#defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

#running "Add a spacer to the left side of the Dock (where the applications are)"
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
#running "Add a spacer to the right side of the Dock (where the Trash is)"
#defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'


################################################
# bot "Standard System Changes"
################################################
# running "always boot in verbose mode (not MacOS GUI mode)"
sudo nvram boot-args="-v"

# running "allow 'locate' command"
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist > /dev/null 2>&1

# running "Set standby delay to 24 hours (default is 1 hour)"
sudo pmset -a standbydelay 86400

# running "Disable the sound effects on boot"
sudo nvram SystemAudioVolume=" "

# running "Menu bar: disable transparency"
# defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# running "Menu bar: hide the Time Machine, Volume, User, and Bluetooth icons"
# for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
#   defaults write "${domain}" dontAutoLoad -array \
#     "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
#     "/System/Library/CoreServices/Menu Extras/Volume.menu" \
#     "/System/Library/CoreServices/Menu Extras/User.menu"
# done;
# defaults write com.apple.systemuiserver menuExtras -array \
#   "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
#   "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
  # "/System/Library/CoreServices/Menu Extras/Battery.menu" \
  # "/System/Library/CoreServices/Menu Extras/Clock.menu"


# running "Set highlight color to green"
defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

# running "Set sidebar icon size to medium"
# defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# running "Always show scrollbars"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# running "Increase window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# running "Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# running "Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# running "Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# running "Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# running "Disable the “Are you sure you want to open this application?” dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

# running "Remove duplicates in the “Open With” menu (also see 'lscleanup' alias)"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# running "Display ASCII control characters using caret notation in standard text views"
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# running "Disable automatic termination of inactive apps"
# defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# running "Disable the crash reporter"
# defaults write com.apple.CrashReporter DialogType -string "none"

# running "Set Help Viewer windows to non-floating mode"
defaults write com.apple.helpviewer DevMode -bool true

# running "Reveal IP, hostname, OS, etc. when clicking clock in login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# running "Restart automatically if the computer freezes"
sudo systemsetup -setrestartfreeze on

# running "Never go into computer sleep mode"
# sudo systemsetup -setcomputersleep Off > /dev/null

# running "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# running "Disable Notification Center and remove the menu bar icon"
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist > /dev/null 2>&1

# running "Disable smart quotes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# running "Disable smart dashes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false


###############################################################################
# bot "Trackpad, mouse, keyboard, Bluetooth accessories, and input"
###############################################################################

# running "Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# running "Trackpad: map bottom right corner to right-click"
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
# defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
# defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# running "Disable 'natural' (Lion-style) scrolling"
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# running "Increase sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# running "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# running "Use scroll gesture with the Ctrl (^) modifier key to zoom"
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# running "Follow the keyboard focus while zoomed in"
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# running "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# running "Set a blazingly fast keyboard repeat rate"
# defaults write NSGlobalDomain KeyRepeat -int 2
# defaults write NSGlobalDomain InitialKeyRepeat -int 10

# running "Set language and text formats (english/US)"
# defaults write NSGlobalDomain AppleLanguages -array "en"
# defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
# defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
# defaults write NSGlobalDomain AppleMetricUnits -bool true

# running "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# bot "Configuring the Screen"
###############################################################################

# running "Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# running "Save screenshots to the desktop"
# defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# running "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
# defaults write com.apple.screencapture type -string "png"

# running "Disable shadow in screenshots"
# defaults write com.apple.screencapture disable-shadow -bool true

# running "Enable subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# running "Enable HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# bot "Finder Configs"
###############################################################################
# running "Keep folders on top when sorting by name (Sierra only)"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# running "Allow quitting via ⌘ + Q; doing so will also hide desktop icons"
# defaults write com.apple.finder QuitMenuItem -bool true

# running "Disable window animations and Get Info animations"
# defaults write com.apple.finder DisableAllAnimations -bool true

# running "Set Desktop as the default location for new Finder windows"
# # For other paths, use 'PfLo' and 'file:///full/path/here/'
# defaults write com.apple.finder NewWindowTarget -string "PfDe"
# defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# running "Show hidden files by default"
# defaults write com.apple.finder AppleShowAllFiles -bool true

# running "Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# running "Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

# running "Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

# running "Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true

# running "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# running "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# running "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# running "Enable spring loading for directories"
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# running "Remove the spring loading delay for directories"
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# running "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# running "Disable disk image verification"
# defaults write com.apple.frameworks.diskimages skip-verify -bool true
# defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
# defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# running "Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# running "Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# running "Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# running "Empty Trash securely by default"
defaults write com.apple.finder EmptyTrashSecurely -bool true

# running "Enable AirDrop over Ethernet and on unsupported Macs running Lion"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# running "Show the ~/Library folder"
chflags nohidden ~/Library


# running "Expand the following File Info panes: “General”, “Open with”, and “Sharing & Permissions”"
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true

###############################################################################
# bot "Dock & Dashboard"
###############################################################################

# running "Enable highlight hover effect for the grid view of a stack (Dock)"
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# running "Set the icon size of Dock items to 36 pixels"
# defaults write com.apple.dock tilesize -int 36

# running "Change minimize/maximize window effect to scale"
# defaults write com.apple.dock mineffect -string "scale"

# running "Minimize windows into their application’s icon"
defaults write com.apple.dock minimize-to-application -bool true

# running "Enable spring loading for all Dock items"
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# running "Show indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true

# running "Don’t animate opening applications from the Dock"
# defaults write com.apple.dock launchanim -bool false

# running "Speed up Mission Control animations"
defaults write com.apple.dock expose-animation-duration -float 0.1

# running "Don’t group windows by application in Mission Control"
# # (i.e. use the old Exposé behavior instead)
# defaults write com.apple.dock expose-group-by-app -bool false

# running "Disable Dashboard"
# defaults write com.apple.dashboard mcx-disabled -bool true

# running "Don’t show Dashboard as a Space"
# defaults write com.apple.dock dashboard-in-overlay -bool true

# running "Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

# running "Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0
# running "Remove the animation when hiding/showing the Dock"
defaults write com.apple.dock autohide-time-modifier -float 0

# running "Automatically hide and show the Dock"
# defaults write com.apple.dock autohide -bool true

# running "Make Dock icons of hidden applications translucent"
defaults write com.apple.dock showhidden -bool true

# running "Make Dock more transparent"
defaults write com.apple.dock hide-mirror -bool true

# running "Reset Launchpad, but keep the desktop wallpaper intact"
# find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# bot "Configuring Hot Corners"
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# running "Top left screen corner → Mission Control"
# defaults write com.apple.dock wvous-tl-corner -int 2
# defaults write com.apple.dock wvous-tl-modifier -int 0
# running "Top right screen corner → Desktop"
# defaults write com.apple.dock wvous-tr-corner -int 4
# defaults write com.apple.dock wvous-tr-modifier -int 0
# running "Bottom right screen corner → Start screen saver"
# defaults write com.apple.dock wvous-br-corner -int 5
# defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# bot "Configuring Safari & WebKit"
###############################################################################

# running "Set Safari’s home page to ‘about:blank’ for faster loading"
defaults write com.apple.Safari HomePage -string "about:blank"

# running "Prevent Safari from opening ‘safe’ files automatically after downloading"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# running "Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# running "Hide Safari’s bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false

# running "Hide Safari’s sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# running "Disable Safari’s thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# running "Enable Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# running "Make Safari’s search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# running "Remove useless icons from Safari’s bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# running "Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# running "Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# bot "Configuring Mail"
###############################################################################


# running "Disable send and reply animations in Mail.app"
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# running "Copy email addresses as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# running "Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app"
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"

# running "Display emails in threaded mode, sorted by date (oldest at the top)"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# running "Disable inline attachments (just show the icons)"
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# running "Disable automatic spell checking"
defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"

###############################################################################
# bot "Spotlight"
###############################################################################

# running "Hide Spotlight tray-icon (and subsequent helper)"
# sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# running "Disable Spotlight indexing for any volume that gets mounted and has not yet been indexed"
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# running "Change indexing order and disable some file types from being indexed"
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}'
# running "Load new settings before rebuilding the index"
killall mds > /dev/null 2>&1
# running "Make sure indexing is enabled for the main volume"
sudo mdutil -i on / > /dev/null
#running "Rebuild the index from scratch"
#sudo mdutil -E / > /dev/null

###############################################################################
# bot "Terminal & iTerm2"
###############################################################################

# running "Only use UTF-8 in Terminal.app"
# defaults write com.apple.terminal StringEncodings -array 4
#
# running "Use a modified version of the Solarized Dark theme by default in Terminal.app"
# TERM_PROFILE='Solarized Dark xterm-256color';
# CURRENT_PROFILE="$(defaults read com.apple.terminal 'Default Window Settings')";
# if [ "${CURRENT_PROFILE}" != "${TERM_PROFILE}" ]; then
# 	open "./configs/${TERM_PROFILE}.terminal";
# 	sleep 1; # Wait a bit to make sure the theme is loaded
# 	defaults write com.apple.terminal 'Default Window Settings' -string "${TERM_PROFILE}";
# 	defaults write com.apple.terminal 'Startup Window Settings' -string "${TERM_PROFILE}";
# fi;

#running "Enable “focus follows mouse” for Terminal.app and all X11 apps"
# i.e. hover over a window and start `typing in it without clicking first
defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true
# running "Installing the Solarized Light theme for iTerm (opening file)"
# open "./configs/Solarized Light.itermcolors"
# running "Installing the Patched Solarized Dark theme for iTerm (opening file)"
# open "./configs/Solarized Dark Patch.itermcolors"

# running "Don’t display the annoying prompt when quitting iTerm"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
# running "hide tab title bars"
# defaults write com.googlecode.iterm2 HideTab -bool true
# running "set system-wide hotkey to show/hide iterm with ^\`"
# defaults write com.googlecode.iterm2 Hotkey -bool true
# running "hide pane titles in split panes"
defaults write com.googlecode.iterm2 ShowPaneTitles -bool true
# running "animate split-terminal dimming"
defaults write com.googlecode.iterm2 AnimateDimming -bool true
# defaults write com.googlecode.iterm2 HotkeyChar -int 96;
# defaults write com.googlecode.iterm2 HotkeyCode -int 50;
defaults write com.googlecode.iterm2 FocusFollowsMouse -int 1;
# defaults write com.googlecode.iterm2 HotkeyModifiers -int 262401;
# running "Make iTerm2 load new tabs in the same directory"
/usr/libexec/PlistBuddy -c "set \"New Bookmarks\":0:\"Custom Directory\" Recycle" ~/Library/Preferences/com.googlecode.iterm2.plist
# running "setting fonts"
# defaults write com.googlecode.iterm2 "Normal Font" -string "Hack-Regular 12";
# defaults write com.googlecode.iterm2 "Non Ascii Font" -string "RobotoMonoForPowerline-Regular 12";
# 
# running "reading iterm settings"
defaults read -app iTerm > /dev/null 2>&1;


###############################################################################
# bot "Time Machine"
###############################################################################

# running "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# running "Disable local Time Machine backups"
hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# bot "Activity Monitor"
###############################################################################

# running "Show the main window when launching Activity Monitor"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# running "Visualize CPU usage in the Activity Monitor Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5

# running "Show all processes in Activity Monitor"
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# running "Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# bot "Address Book, Dashboard, iCal, TextEdit, and Disk Utility"
###############################################################################

# running "Enable the debug menu in Address Book"
defaults write com.apple.addressbook ABShowDebugMenu -bool true

# running "Enable Dashboard dev mode (allows keeping widgets on the desktop)"
defaults write com.apple.dashboard devmode -bool true

# running "Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -int 0
# running "Open and save files as UTF-8 in TextEdit"
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# running "Enable the debug menu in Disk Utility"
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# bot "Mac App Store"
###############################################################################

# running "Enable the WebKit Developer Tools in the Mac App Store"
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# running "Enable Debug Menu in the Mac App Store"
defaults write com.apple.appstore ShowDebugMenu -bool true

###############################################################################
# bot "Messages"
###############################################################################

# running "Disable automatic emoji substitution (i.e. use plain text smileys)"
# defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# running "Disable smart quotes as it’s annoying for messages that contain code"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# running "Disable continuous spell checking"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

###############################################################################
# bot "SizeUp.app"
###############################################################################

# running "Start SizeUp at login"
# defaults write com.irradiatedsoftware.SizeUp StartAtLogin -bool true

# running "Don’t show the preferences window on next start"
# defaults write com.irradiatedsoftware.SizeUp ShowPrefsOnNextStart -bool false

# killall cfprefsd

###############################################################################
# Kill affected applications                                                  #
###############################################################################
# bot "OK. Note that some of these changes require a logout/restart to take effect. Killing affected applications (so they can reboot)...."
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Mail" "Messages" "Safari" "SizeUp" "SystemUIServer" \
  "iCal" "Terminal"; do
  killall "${app}" > /dev/null 2>&1
done


# bot "Woot! All done. Remember to kill this terminal and launch iTerm"

# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.

echo "› sudo softwareupdate -i -a"
sudo softwareupdate -i -a
