macOS setup
===========

Setting up a new macOS installation from scratch, rather than using the
Migration Assistant or restoring from backups/copies.


## After installing macOS

Create the non-primary account first. I use [`king`](https://flickr.com/photos/tags/kingofthebritons).

* Do not sign into iCloud.
* System Preferences → Users & Groups → Login Options → Display login window
  as: Name and password.
* Add primary account. I use `norm`.
* Right-click on account for Advanced Options → Login shell: /bin/bash.
* System Preferences → Sharing → set the Computer Name.
* System Preferences → Software Update; install any outstanding updates.

Restart the computer, then log into primary account.

* Sign into iCloud.
* Set Desktop & Documents Folders to be synced.
* Open Finder, wait for the Desktop, Documents, and iCloud Drive folders
  to fully download.

Log out, and into non-primary account.

* Open Terminal:

```
# this copies some preserved preferences (eg Terminal) into 
# Library/Preferences *before* the app is used so cfprefsd
# caches my preferred settings, not the defaults
sudo su -
cd ~norm
Documents/macos/copy_prefs.sh
```

Restart the computer, log into the primary account.

* App Store → Store → Sign in; download 1Password, and unlock it.
* System Preferences → Security & Privacy → Privacy → Full Disk Access → add Terminal.
* System Preferences → Security & Privacy → Privacy → Accessibility → add Terminal.
* Open Terminal.

```bash
# setup enough tools to get kitout working
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
git clone git@github.com:norm/macos_setup Code/norm/macos_setup
cd Code/norm/macos_setup
./setup/install.sh

# install a modern bash using homebrew
brew install coreutils bash
brew pin bash
target=$(realpath /usr/local/bin/bash)
rm /usr/local/bin/bash && install -m755 $target /usr/local/bin/bash
sudo chsh -s /usr/local/bin/bash norm

# install everything else using kitout
curl -o /tmp/kitout https://raw.githubusercontent.com/norm/kitout/main/kitout.sh
install -m0755 /tmp/kitout /usr/local/bin/kitout
kitout .
```

Done-zo.
