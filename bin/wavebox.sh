#!/usr/bin/env bash

# Function to extract version from URL
get_version() {
    url="$1"
    location=$(curl -sI "$url" | grep -i '^location')
    version=$(echo "$location" | grep -oP '(?<=_).*(?=_x86_64\.AppImage)')
    echo "$version"
}

# Main script
download_url="https://download.wavebox.app/latest/stable/linux/appimage"
version=$(get_version "$download_url")

if [ -z "$version" ]; then
    echo "Failed to retrieve version from URL"
    exit 1
fi

tar_url="https://download.wavebox.app/stable/linux/tar/Wavebox_${version}.tar.gz"
nix-prefetch-url "$tar_url" 