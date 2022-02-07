#!/bin/bash -euo pipefail

# archived copy now it has been removed from Mac App Store
hg_tar="$HOME/Library/Mobile Documents/com~apple~CloudDocs/kit/hg.tar.gz"

if [ -s "$hg_tar" ]; then
    silent_pushd /Applications
    tar zxf "$hg_tar"
    silent_popd
fi
