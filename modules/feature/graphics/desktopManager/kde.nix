{
  config,
  pkgs,
  lib,
  user,
  ...
}: let
  graphics = config.host.feature.graphics;
in {
  config = lib.mkIf (graphics.enable && graphics.desktopManager == "kde") {
    # Configure keymap in X11
    services = {
      xserver = {
        desktopManager = {
          plasma5 = {enable = true;};
        };
        displayManager = {
          lightdm = {
            enable = graphics.enable && graphics.displayManager.manager == "lightdm";
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
      # todo
      libsForQt5.polkit-qt
      libsForQt5.polkit-kde-agent
    ];
  };
}
