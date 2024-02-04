{ config
, pkgs
, lib
, user
, ...
}: {
  options = {
    kde = {
      enable = lib.mkEnableOption {
        description = "Enable kde.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.kde {
    home-manager.users.${user} = {
      home = {
        packages = with pkgs; [
          dconf
          libsForQt5.polkit-kde-agent
        ];
      };
    };

    # Configure keymap in X11
    services = {
      xserver = {
        desktopManager = {
          plasma5 = { enable = true; };
        };
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
