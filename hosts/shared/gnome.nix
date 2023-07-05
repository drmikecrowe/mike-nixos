{ config, pkgs, inputs, system, ... }:

{
  # Enable the Pantheon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    enable = true;
    libinput = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  security.pam.services.lightdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true; # keyring GUI

  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
    _1password-gui.polkitPolicyOwners = [ "mcrowe" ];
  };

}
