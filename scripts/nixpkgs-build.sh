#!/usr/bin/env bash
set -euo pipefail

# --- Constants ---
SWAP_FILE="/swapfile"
SWAP_SIZE="32GB"
REPO_DIR="$HOME/git/nixpkgs"
MAIN_BRANCH="master"
DEFAULT_PACKAGE="librewolf"

# --- Functions ---
help() {
    cat <<EOF
Usage: $(basename "$0") PR-number [PACKAGE]

PR-number must be a valid numeric GitHub PR number.
PACKAGE is optional and defaults to $DEFAULT_PACKAGE.
EOF
    exit 1
}

cleanup() {
    if [[ -f "$SWAP_FILE" ]]; then
        echo "Cleaning up swapfile..."
        sudo swapoff "$SWAP_FILE"
        sudo rm "$SWAP_FILE"
    fi
}

# --- Validate Arguments ---
if [[ $# -lt 1 || $# -gt 2 ]]; then
    help
fi

PR="$1"
PACKAGE="${2:-$DEFAULT_PACKAGE}"

# Validate PR is numeric
if ! [[ "$PR" =~ ^[0-9]+$ ]]; then
    echo "Error: PR number must be a numeric value."
    help
fi

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
git checkout "$MAIN_BRANCH"

# Cleanup branch if it exists
BRANCH_NAME="${PACKAGE}-nixpkgs-test"
if git show-ref --quiet refs/heads/"$BRANCH_NAME"; then
    git branch -D "$BRANCH_NAME"
fi

# Fetch and checkout
echo "Fetching and checking out PR #$PR for package '$PACKAGE'..."
git fetch upstream pull/"$PR"/head:"$BRANCH_NAME"
git checkout "$BRANCH_NAME"

# Build and run
echo "Building $PACKAGE..."
nom build .#"$PACKAGE"
cleanup || true
./result/bin/"$PACKAGE"
