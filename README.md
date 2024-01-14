# Mike's NixOS config

Heavily inspired by https://github.com/nmasur/dotfiles (well, lifted mostly)

## New machine

```sh
nix-shell -p git-crypt neovim home-manager
nix develop


nix-env -i nvim
nix-env -iA nvim
nix-env -iA neovim
nix run home-manager/master switch -- --flake . -n
nix run home-manager/master switch -n -- --flake . 
nix run home-manager/master -- switch - --flake . 
nix run home-manager/master -- switch -n --flake . 
nix run home-manager/master -- -n switch --flake . 
nix-shell -p home-manager
home-manager switch --flake . -b backup
```

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
