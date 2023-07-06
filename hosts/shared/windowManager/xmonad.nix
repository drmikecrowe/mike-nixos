{ config, pkgs, inputs, system, ... }:

{
  services.autorandr.enable = true;
  services.xserver = {
    # xrandrHeads = [{ output = "HDMI-0"; primary = true; } { output = "VGA-0"; }];
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = hpkgs: [
          hpkgs.xmobar
          hpkgs.xmonad-screenshot
        ];
      };
    };
    displayManager = {
      defaultSession = "none+xmonad";
      lightdm = {
        greeters.enso = {
          enable = true;
          blur = true;
          # extraConfig = ''
          #   default-wallpaper=/usr/share/streets_of_gruvbox.png
          # '';
        };
      };
      # sessionCommands = ''
      #   xrandr --output VGA-0 --mode 1400x900 --pos 2560x336 --rotate normal --output DVI-D-0 --off --output HDMI-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal
      #   ./.fehbg
      #   '';
    };

  };

  environment.systemPackages = with pkgs; [
    aramdr
    gnome.gnome-tweaks
    xfce.thunar
  ];

}
