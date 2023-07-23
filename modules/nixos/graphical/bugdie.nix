{ config, pkgs, lib, ... }: {

  options = {
    budgie = {
      enable = lib.mkEnableOption {
        description = "Enable Budgie.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.budgie.enable {
    home-manager.users.${config.user} = {
      home = {
        packages = with pkgs; [
          dconf
          budgie.budgie-desktop-with-plugins
        ];
      };
    };

    # Configure keymap in X11
    services = {
      xserver = {
        desktopManager = { budgie = { enable = true; }; };
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
