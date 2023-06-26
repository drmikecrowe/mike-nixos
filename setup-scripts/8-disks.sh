for i in ${DISK}; do
  sed -i \
  "s|/dev/disk/by-id/|${i%/*}/|" \
  "${MNT}"/etc/nixos/hosts/xps15/default.nix
  break
done

diskNames=""
for i in ${DISK}; do
  diskNames="${diskNames} \"${i##*/}\""
done

sed -i "s|\"bootDevices_placeholder\"|${diskNames}|g" \
  "${MNT}"/etc/nixos/hosts/xps15/default.nix

sed -i "s|\"abcd1234\"|\"$(head -c4 /dev/urandom | od -A none -t x4| sed 's| ||g' || true)\"|g" \
  "${MNT}"/etc/nixos/hosts/xps15/default.nix

sed -i "s|\"x86_64-linux\"|\"$(uname -m || true)-linux\"|g" \
  "${MNT}"/etc/nixos/flake.nix

cp "$(command -v nixos-generate-config || true)" ./nixos-generate-config

chmod a+rw ./nixos-generate-config

# shellcheck disable=SC2016
echo 'print STDOUT $initrdAvailableKernelModules' >> ./nixos-generate-config

kernelModules="$(./nixos-generate-config --show-hardware-config --no-filesystems | tail -n1 || true)"

sed -i "s|\"kernelModules_placeholder\"|${kernelModules}|g" \
  "${MNT}"/etc/nixos/hosts/xps15/default.nix
