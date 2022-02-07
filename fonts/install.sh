while IFS= read -r font; do
    cp "$font" $HOME/Library/Fonts
done < <(find $HOME/Dropbox/Fonts -name '*.otf')
