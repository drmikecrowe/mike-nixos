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
        displayManager = { sddm = { enable = true; }; };
      };
    };

    programs = {
      dconf.enable = true;
    };

  };

}
