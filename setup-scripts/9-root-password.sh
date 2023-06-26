set -ex

if [[ -z $rootPwd ]]; then
  rootPwd=$(mkpasswd -m SHA-512)
fi

sed -i \
"s|rootHash_placeholder|${rootPwd}|" \
"${MNT}/etc/nixos/configuration.nix"


