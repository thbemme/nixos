#!/usr/bin/env bash
set -euo pipefail

# --- Constants ---
SWAP_FILE="/swapfile"
SWAP_SIZE="32GB"
REPO_DIR="$HOME/git/nixpkgs"

# --- Functions ---
help() {
    cat <<EOF
Usage: $(basename "$0") PR-number

PR-number must be a valid numeric GitHub PR number.
EOF
    exit 1
}

cleanup() {
    if [[ -f "$SWAP_FILE" ]]; then
        echo "Cleaning up swapfile..."
        sudo swapoff "$SWAP_FILE" && sudo rm "$SWAP_FILE"
    fi
}

# --- Main ---
# Validate input
if [[ $# -ne 1 || ! "$1" =~ ^[0-9]+$ ]]; then
    help
fi

PR="$1"
trap cleanup EXIT # Ensure cleanup runs on script exit

# Setup swap
if [[ ! -f "$SWAP_FILE" ]]; then
    echo "Creating $SWAP_SIZE swapfile..."
    sudo mkswap -U clear --size "$SWAP_SIZE" --file "$SWAP_FILE"
    sudo swapon "$SWAP_FILE"
fi

# Process PR
cd "$REPO_DIR" || {
    echo "Error: Failed to enter $REPO_DIR"
    exit 1
}
echo "Reviewing PR #$PR..."
nixpkgs-review pr "$PR"
