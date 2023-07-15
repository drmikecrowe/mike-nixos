[Back to README](../README.md)

---

Taken from [nmasur/dotfiles](https://github.com/drmikecrowe/mike-nixos)

# Installation

## NixOS - From Existing System

If you're already running NixOS, you can switch to this configuration with the
following command:

```bash
nix-shell -p nixVersions.stable
sudo nixos-rebuild switch --flake github:drmikecrowe/mike-nixos#xps15
```

## Windows - From NixOS WSL

After [installing NixOS on
WSL](https://xeiaso.net/blog/nix-flakes-4-wsl-2022-05-01), you can switch to
the WSL configuration:

```
nix-shell -p nixVersions.stable
sudo nixos-rebuild switch --flake github:drmikecrowe/mike-nixos#hydra
```

You should also download the
[FiraCode](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip)
font and install it on Windows. Install [Alacritty](https://alacritty.org/) and
move the `windows/alacritty.yml` file to
`C:\Users\<user>\AppData\Roaming\alacritty`.

## macOS

To get started on a bare macOS installation, first install Nix:

```bash
sh -c "$(curl -L https://nixos.org/nix/install)"
```

Then use Nix to build nix-darwin:

```bash
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```

Then switch to the macOS configuration:

```bash
darwin-rebuild switch --flake github:drmikecrowe/mike-nixos#lookingglass
```

