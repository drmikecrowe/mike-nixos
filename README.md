# Mike's NixOS config

Heavily inspired by https://github.com/nmasur/dotfiles (well, lifted mostly)

## Conflict in mimeapps.list 

Change `mike-nixos/modules/nixos/graphical/applications.nix` and ensure new entries are added.

# System Configurations

This repository contains configuration files for my NixOS, macOS, and WSL
hosts.

They are organized and managed by [Nix](https://nixos.org), so some of the
configuration may be difficult to translate to a non-Nix system.

# Flake Templates

You can also use the [templates](./templates/) as flakes for starting new
projects:

```bash
nix flake init --template github:drmikecrowe/mike-nixos#typescript
```

```
# THIS WIPES EVERYTHING
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko hosts/xps15/disks.nix

# This mounts everything
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode mount hosts/xps15/disks.nix
```

```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode mount hosts/xps15/disks.nix
TMPDIR=/tmp nixos-install --no-root-passwd --impure --flake .#xps15
```

```
sudo rsync -aHAXx --info=progress2 keep /mnt
```
