#!/usr/bin/env bash
for url in https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml https://github.com/dracula/gtk/archive/refs/heads/standard-buttons.zip https://github.com/dracula/gtk/files/5214870/Dracula.zip; do
    if HASH=$(nix-prefetch-url "$url" --unpack 2>/dev/null); then
        BASE64_HASH=$(nix hash convert --from nix32 --to base64 --hash-algo sha256 "$HASH")
        echo "${url}: sha256-${BASE64_HASH}"
    elif HASH=$(nix-prefetch-url "$url" 2>/dev/null); then
        BASE64_HASH=$(nix hash convert --from nix32 --to base64 --hash-algo sha256 "$HASH")
        echo "${url}: sha256-${BASE64_HASH}"
    else
        echo "Failed to fetch ${url}"
        continue
    fi
done
