{ config, pkgs, lib, ... }: {

  options = {
    kde = {
      enable = lib.mkEnableOption {
        description = "Enable kde.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.kde.enable {
    home-manager.users.${config.user} = {
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
        desktopManager = { plasma5 = { enable = true; }; };
        # displayManager = { sddm = { enable = true; }; };
        displayManager = {
          lightdm = {
            inherit (config.services.xserver) enable;
            # background = config.wallpaper;

            # Make the login screen dark
            greeters = {
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

    programs = {
      dconf.enable = true;
    };

  };

}
