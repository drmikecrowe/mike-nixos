#!/usr/bin/env bash

# see: https://gist.github.com/steshaw/4b049480d82608d19573e376c2a73ae4

set -euo pipefail

# Always use the by-id aliases for devices, otherwise ZFS can choke on imports.
DISK=${DISK:-/dev/DISK/by-id/nvme-Fanxiang_S500PRO_2TB_FXS500PRO231912172}
EFI=${EFI:-true}
SWAPSIZE=5
RESERVE=1

function Usage() {
  echo "usage: $0 install|revert" >&2
  exit 2
}

[[ $# -ne 1 ]] && Usage
command=$1; shift

if [[ $command == install ]]; then
  # Partition 2 will be the boot partition, needed for legacy (BIOS) boot.
  sgdisk -a1 -n2:34:2047 -t2:EF02 "$DISK"

  if [[ $EFI == true ]]; then
    # If you need EFI support, make an EFI partition:
    sgdisk -n3:1M:+512M -t3:EF00 "$DISK"
  fi

  sgdisk -n4:513M:$SWAPSIZE -t4:8200 $DISK

  # Partition 1 will be the main ZFS partition, using up the remaining space on the drive.
  sgdisk -n1:0:0 -t1:BF01 "$DISK"

  # Create the pool. If you want to tweak this a bit and you're feeling adventurous, you
  # might try adding one or more of the following additional options:
  # To disable writing access times:
  #   -O atime=off
  # To enable filesystem compression:
  #   -O compression=lz4
  # To enable normalizing unicode filenames (and implicitly set utf8only=on):
  #   -O normalization=formD
  # To improve performance of certain extended attributes:
  #   -O xattr=sa
  # For systemd-journald posixacls are required
  #   -O acltype=posixacl
  # To specify that your drive uses 4K sectors instead of relying on the size reported
  # by the hardware (note small 'o'):
  #   -o ashift=12
  #
  # The 'mountpoint=none' option disables ZFS's automount machinery; we'll use the
  # normal fstab-based mounting machinery in Linux.
  # '-R /mnt' is not a persistent property of the FS, it'll just be used while we're installing.

  function CreatePool() {
    zpool create \
      -O mountpoint=none \
      -O atime=off \
      -O xattr=sa \
      -O compression=zstd \
      -o ashift=12 \
      -O acltype=posixacl \
      -O canmount=off \
      -O dnodesize=auto \
      -O normalization=formD \
      -O relatime=on \
      -R /mnt \
      rpool "${DISK}-part1"
  }
  # Since creating the pool can fail, we repeat a number of times.
  CreatePool || CreatePool || CreatePool # 3 times lucky

  # Create the filesystems. This layout is designed so that /home is separate from the root
  # filesystem, as you'll likely want to snapshot it differently for backup purposes. It also
  # makes a "nixos" filesystem underneath the root, to support installing multiple OSes if
  # that's something you choose to do in future.
  zfs create -o mountpoint=none rpool/root
  zfs create -o mountpoint=legacy rpool/root/root
  zfs snapshot rpool/root/root@blank
  zfs create -o mountpoint=legacy rpool/root/nixos
  zfs create -o mountpoint=none rpool/safe
  zfs create -o mountpoint=legacy rpool/safe/persist
  zfs create -o mountpoint=legacy rpool/safe/home

  # Mount the filesystems manually. The nixos installer will detect these mountpoints
  # and save them to /mnt/nixos/hardware-configuration.nix during the install process.
  mount -t zfs rpool/root/nixos /mnt
  mkdir /mnt/home
  mount -t zfs rpool/safe/home /mnt/home
  mkdir /mnt/persist
  mount -t zfs rpool/safe/persist /mnt/persist

  cryptsetup open --type plain --key-file /dev/random $DISK-part4 $DISK-part4
  mkswap /dev/mapper/"${DISK##*/}"-part4
  swapon /dev/mapper/"${DISK##*/}"-part4

  # If you need to boot EFI, you'll need to set up /boot as a non-ZFS partition.
  if [[ $EFI == true ]]; then
    mkfs.vfat -n EFI "$DISK-part3"
    mkdir /mnt/boot
    mount "$DISK-part3" /mnt/boot
  fi

  # Generate the NixOS configuration, as per the NixOS manual.
  nixos-generate-config --root /mnt

  configuration=/mnt/etc/nixos/configuration.nix

  #
  # Edit /mnt/etc/nixos/configuration.nix and add the following line:
  #
  #  boot.supportedFilesystems = [ "zfs" ];
  #
  sed -i \
    -e '/^\s*#.*boot/a\ \ boot.supportedFilesystems = [ "zfs" ];' \
     /mnt/etc/nixos/configuration.nix
  # Ensure sed worked.
  grep -q '^  boot.supportedFilesystems = \[ "zfs" \];$' /mnt/etc/nixos/configuration.nix

  #
  # Also, set the networking.hostId option, which ZFS requires:
  #
  #  networking.hostId = "<random 8-digit hex string>"
  #
  # See https://nixos.org/nixos/manual/options.html#opt-networking.hostId for more.
  #
  sed -i \
    -e "/hostName/a\ \ networking.hostId = \"$(head -c 8 /etc/machine-id)\";" \
     $configuration
  # Ensure sed worked.
  egrep -q '^  networking.hostId = "[0-9a-f]{8}";$' $configuration

  cat <<!

You may want to customise your configuration:

$ vim $configuration

Continue with installation!

$ nixos-install
!

elif [[ $command == wipe ]]; then 

  blkdiscard -f $DISK
  partprobe $DISK
  udevadm settle

elif [[ $command == revert ]]; then

  umount /mnt/home || true
  umount /mnt/boot || true
  umount /mnt || true

  parted "$DISK" --script -- rm 1 || true
  parted "$DISK" --script -- rm 2 || true
  parted "$DISK" --script -- rm 3 || true

  zfs destroy -r rpool || true
  zpool destroy rpool || true

else
  Usage
fi
