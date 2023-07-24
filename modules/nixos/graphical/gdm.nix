{ config, pkgs, lib, ... }: {

  options = {
    gdm = {
      enable = lib.mkEnableOption {
        description = "Enable gdm.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.gdm.enable {
    # Configure keymap in X11
    services = {
      xserver = {
        displayManager = {
          gdm = {
            inherit (config.services.xserver) enable;
          };
        };
      };
    };

  };

}
