{ config, pkgs, inputs, system, ... }:

{
  services.xserver = {
    # xrandrHeads = [{ output = "HDMI-0"; primary = true; } { output = "VGA-0"; }];
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = hpkgs: [
          hpkgs.xmobar
        ];
      };
    };
    displayManager = {
      defaultSession = "none+xmonad";
      # sessionCommands = ''
      #   xrandr --output VGA-0 --mode 1400x900 --pos 2560x336 --rotate normal --output DVI-D-0 --off --output HDMI-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal
      #   ./.fehbg
      #   '';
    };

  };

  # For flatpak support
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

}
