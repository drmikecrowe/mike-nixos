{ config, pkgs, inputs, system, ... }:

{
  imports = [
    ../console.nix
    ../gui.nix
    ../lightdm.nix
  ];

  # gtk = {
  #   theme = {
  #     package = pkgs.gnome.gnome-themes-extra;
  #     name = "Adwaita";
  #   };
  # };

  # Configure keymap in X11
  services = {
    xserver = {
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
    gnome = {
      gnome-keyring = {
        enable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  security.pam.services.lightdm.enableGnomeKeyring = true;

  programs.seahorse.enable = true; # keyring GUI
}
