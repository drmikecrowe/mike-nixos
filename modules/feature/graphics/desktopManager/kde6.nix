{
  config,
  pkgs,
  lib,
  user,
  ...
}: let
  graphics = config.host.feature.graphics;
in {
  config = lib.mkIf (graphics.enable && graphics.desktopManager == "kde6") {
    # Configure keymap in X11
    services = {
      desktopManager = {
        plasma6 = {enable = true;};
      };
      xserver = {
        displayManager = {
          lightdm = {
            inherit (config.services.xserver) enable;
            # background = config.wallpaper;

            # Make the login screen dark
            greeters = {
              slick.enable = false;
              enso = {
                enable = true;
                blur = true;
              };
            };

            # Show default user
            extraSeatDefaults = ''
              greeter-hide-users = false
            '';
          };
        };
      };
    };

    environment.systemPackages = with pkgs; [
      kdePackages.polkit-kde-agent-1
      kdePackages.qt5compat
    ];
  };
}
