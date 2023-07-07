{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    direnv
    gcc
    mc
    vim
    nmap
    parted
    bat
    pkgs.fishPlugins.plugin-git
    pkgs.fishPlugins.grc
    pkgs.fishPlugins.colored-man-pages
  ];

  programs.fish.enable = true;
}
