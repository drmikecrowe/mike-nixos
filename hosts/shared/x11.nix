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
    aramdr
    xfce.thunar
  ];

  gtk = {
    enable = true;
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  programs = {
    _1password = {
      enable = true;
    };
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "mcrowe" ];
    };

    terminator = {
      enable = true;
      config = {
        global_config.borderless = true;
      };
    };
  };
}
