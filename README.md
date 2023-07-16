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
