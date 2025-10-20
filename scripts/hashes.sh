#!/usr/bin/env bash
# https://git.kbnetcloud.de/riza/nixos/src/branch/main/scripts/hashes.sh

# Function to display help
help() {
    echo -e "\nFetch and update hashes for pkg.fetch* files\n\nUsage:\n$(basename "$0") file.nix\n"
    exit 1
}

# Check if a .nix file is provided
if [[ "$#" -ne 1 || ! "$1" =~ \.nix$ ]]; then
    help
fi

FILE="$1"

# Extract hashes from gnome.nix
declare -A EXPECTED_HASHES

echo -e "\n\033[0;33mExtracting urls and hashes from $FILE:\033[0m\n"
while IFS= read -r URL; do
	HASH=$(grep -A2 "$URL" "$FILE" | grep 'hash = "sha256-' | awk -F'"' '{print $2}')
	EXPECTED_HASHES["$URL"]=$HASH
	echo -e "$URL -> $HASH"
done < <(grep "url =" "$FILE" | awk -F'"' '{print $2}')

echo -e "\n\033[0;33mFetching current hashes:\033[0m\n"
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
		sed -i "s/${EXPECTED_HASHES[$url]}/$COMPUTED_HASH/g" "$FILE"
		echo -e "\033[0;32mUpdated hash for ${url} to ${COMPUTED_HASH}\033[0m"
	else
		echo -e "\033[0;32m${url}: ${COMPUTED_HASH}\033[0m"
	fi
done
