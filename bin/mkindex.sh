#!/usr/bin/env bash

mklist() {
  ls -1b $1 | grep -v default.nix | while read FIL; do
    echo "./$FIL"
  done
}

rm $1/default.nix

cat <<EOF > /tmp/default.nix
{dotfiles, ...}: {
  imports = [
$(mklist $1)
  ];
}

EOF

mv /tmp/default.nix $1/default.nix
alejandra $1
