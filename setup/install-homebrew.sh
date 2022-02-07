#!/bin/bash -euo pipefail

/bin/bash -c $(
    curl --fail --silent --show-error --location \
        https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
)

brew tap homebrew/cask-fonts
