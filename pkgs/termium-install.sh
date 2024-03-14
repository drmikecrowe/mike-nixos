#!/bin/sh

err() {
    echo "$1" >&2
    exit 1
}

# Loosely adapted from rustup-init.sh (see sh.rustup.rs)
get_architecture() {
    local _ostype _cputype _arch
    _ostype="$(uname -s)"
    _cputype="$(uname -m)"

    if [ "$_ostype" = Darwin ] && [ "$_cputype" = i386 ]; then
        # Darwin `uname -m` lies
        if sysctl hw.optional.x86_64 | grep -q ': 1'; then
            _cputype=x86_64
        fi
    fi

    case "$_ostype" in
        Linux) _ostype=unknown-linux-gnu;;
        Darwin) _ostype=apple-darwin;;
        MINGW* | MSYS* | CYGWIN* | Windows_NT) _ostype=pc-windows-gnu;;
        *) err "unrecognized OS type: $_ostype";;
    esac

    case "$_cputype" in
        i386 | i486 | i686 | i786 | x86) _cputype=i686;;
        xscale | arm | armv6l | armv7l | armv8l) _cputype=arm;;
        aarch64 | arm64) _cputype=aarch64;;
        x86_64 | x86-64 | x64 | amd64) _cputype=x86_64;;
        *) err "unknown CPU type: $_cputype";;

    esac

    _arch="${_cputype}-${_ostype}"

    RETVAL="$_arch"
}

echo_bold() {
  echo -e "\033[1m$1\033[0m"
}

downloader() {
    local _arch="$1"
    local _bin_name="termium"
    local _base_url="https://github.com/Exafunction/codeium/releases"
    local _version="0.2.0"
    local _url="${_base_url}/download/${_bin_name}-v${_version}/${_bin_name}_${_arch}"

    echo "Downloading $_bin_name from $_url"
    curl -fLo "$_bin_name" "$_url" || exit 1

    chmod +x "$_bin_name"

    echo "Moving $_bin_name to /usr/local/bin"
    sudo mkdir -p "/usr/local/bin"
    sudo mv "$_bin_name" "/usr/local/bin/$_bin_name"
}

main() {
    get_architecture || return 1
    local _arch="$RETVAL"

    case "$_arch" in
        x86_64-unknown-linux-gnu | aarch64-unknown-linux-gnu | x86_64-apple-darwin | aarch64-apple-darwin)
            # supported platform
            downloader $_arch || return 1;;
        *)
            err "Unsupported platform: $_arch";;
    esac

    echo "Download complete. To finish setup run the following commands:"
    # Echo the command in bold text.
    echo_bold "  termium auth"
    echo_bold "  termium shell-hook install"
    echo ""
    echo "You can also run the following to learn more about termium:"
    echo_bold "  termium --help"
}

main || exit 1
