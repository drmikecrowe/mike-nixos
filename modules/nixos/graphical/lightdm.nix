{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    lightdm = {
      enable = lib.mkEnableOption {
        description = "Enable lightdm.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.lightdm.enable {
    # Configure keymap in X11
    services = {
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
  };
}
