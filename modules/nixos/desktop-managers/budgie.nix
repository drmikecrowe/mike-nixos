{ config
, pkgs
, lib
, user
, ...
}: {
  options = {
    budgie = {
      enable = lib.mkEnableOption {
        description = "Enable Budgie.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.budgie.enable {
    home-manager.users.${user} = {
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
      };
    };
  };
}
