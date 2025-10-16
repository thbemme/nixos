#!/usr/bin/env bash
file="$HOME/git/nixos/home/gnome.nix"

# Extract hashes from gnome.nix
declare -A EXPECTED_HASHES=(
    ["https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml"]=$(grep -A2 'dracula.xml' "$file" | grep 'hash = "sha256-' | awk -F'"' '{print $2}')
    ["https://github.com/dracula/gtk/archive/refs/heads/standard-buttons.zip"]=$(grep -A2 'standard-buttons.zip' "$file" | grep 'hash = "sha256-' | awk -F'"' '{print $2}')
    ["https://github.com/dracula/gtk/files/5214870/Dracula.zip"]=$(grep -A2 'Dracula.zip' "$file" | grep 'hash = "sha256-' | awk -F'"' '{print $2}')
)

for url in "${!EXPECTED_HASHES[@]}"; do
    if HASH=$(nix-prefetch-url "$url" --unpack 2>/dev/null); then
        BASE64_HASH=$(nix hash convert --from nix32 --to base64 --hash-algo sha256 "$HASH")
        COMPUTED_HASH="sha256-${BASE64_HASH}"
    elif HASH=$(nix-prefetch-url "$url" 2>/dev/null); then
        BASE64_HASH=$(nix hash convert --from nix32 --to base64 --hash-algo sha256 "$HASH")
        COMPUTED_HASH="sha256-${BASE64_HASH}"
    else
        echo "Failed to fetch ${url}"
        continue
    fi

    if [ "${EXPECTED_HASHES[$url]}" != "$COMPUTED_HASH" ]; then
        echo -e "\033[0;31m${url}: Hash mismatch! Updating gnome.nix...\033[0m"
        sed -i "s/${EXPECTED_HASHES[$url]}/$COMPUTED_HASH/g" "$file"
        echo -e "\033[0;32mUpdated hash for ${url} to ${COMPUTED_HASH}\033[0m"
    else
        echo -e "\033[0;32m${url}: ${COMPUTED_HASH}\033[0m"
    fi
done

