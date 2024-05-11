{
  config,
  pkgs,
  lib,
  user,
  ...
}:
with lib; let
  graphics = config.host.feature.graphics;
in {
  config = lib.mkIf (graphics.enable && graphics.desktopManager == "cinnamon") {
    programs = {
      seahorse.enable = mkDefault true;
    };

    # Configure keymap in X11
    services = {
      xserver = {
        desktopManager = {
          cinnamon = {
            enable = true;
          };
        };
        displayManager = {
          gdm = {
            inherit (config.services.xserver) enable;
          };
          # lightdm = {
          #   inherit (config.services.xserver) enable;
          #   # background = config.wallpaper;
          #
          #   greeters = {
          #     slick.enable = false;
          #     enso = {
          #       enable = true;
          #       blur = true;
          #     };
          #   };
          #
          #   # Show default user
          #   extraSeatDefaults = ''
          #     greeter-hide-users = false
          #   '';
          # };
        };
      };
      gnome = {gnome-keyring = {enable = true;};};
    };

    environment.systemPackages = with pkgs; [
      gparted
      gtk3
      gtk4
    ];

    services.udev.packages = with pkgs; [
      #gnome.gnome-settings-daemon
    ];
  };
}
