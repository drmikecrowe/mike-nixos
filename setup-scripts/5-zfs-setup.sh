set -x

zfs create -p -o mountpoint=legacy rpool/local/root
zfs snapshot rpool/local/root@blank
mount -t zfs rpool/local/root ${MNT}
mkdir ${MNT}/boot
mount $DISK-part1 ${MNT}/boot

zfs create -p -o mountpoint=legacy rpool/local/nix
mkdir ${MNT}/nix
mount -t zfs rpool/local/nix ${MNT}/nix

zfs create -p -o mountpoint=legacy rpool/safe/home
mkdir ${MNT}/home
mount -t zfs rpool/safe/home ${MNT}/home

zfs create -p -o mountpoint=legacy rpool/safe/persist
mkdir ${MNT}/persist
mount -t zfs rpool/safe/persist ${MNT}/persist
