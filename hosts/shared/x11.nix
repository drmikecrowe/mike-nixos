{ config, pkgs, inputs, system, ... }:

{
  # Configure keymap in X11
  services.autorandr.enable = true;
  services.xserver = {
    xkbVariant = "";
    enable = true;
    autorun = true;
    layout = "us";
    libinput = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    arandr
    xfce.thunar
  ];

  programs = {
    _1password = {
      enable = true;
    };
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "mcrowe" ];
    };
  };
}
