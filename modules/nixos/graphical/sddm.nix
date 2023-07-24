{ config, pkgs, lib, ... }: {

  options = {
    sddm = {
      enable = lib.mkEnableOption {
        description = "Enable sddm.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.sddm.enable {
    # Configure keymap in X11
    services = {
      xserver = {
        displayManager = {
          sddm = {
            inherit (config.services.xserver) enable;
          };
        };
      };
    };

  };

}
