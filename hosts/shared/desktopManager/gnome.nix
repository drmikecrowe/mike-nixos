{ config, pkgs, inputs, system, ... }:

{
  # Configure keymap in X11
  services.xserver = {
    desktopManager = {
      gnome = {
        enable = true;
        enableGnomeKeyring = true;
        gnome-keyring = {
          enable = true;
        };
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
