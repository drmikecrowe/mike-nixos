{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.hardware.bluetooth;
in
  with lib; {
    options = {
      host.hardware.bluetooth = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enable Bluetooth";
        };
      };
    };

    config = mkIf cfg.enable {
      #boot.kernelParams = ["btusb"];
      hardware.bluetooth = {
        enable = true;
        # package = pkgs.bluez5-experimental;
        #hsphfpd.enable = true;
        powerOnBoot = true;
        # disabledPlugins = ["sap"];
        # settings = {
        #   General = {
        #     JustWorksRepairing = "always";
        #     MultiProfile = "multiple";
        #   };
        # };
        settings = {
          General = {
            Name = "xps15";
            ControllerMode = "dual";
            FastConnectable = "true";
            Experimental = "true";
            Enable = "Source,Sink,Media,Socket";
            MultiProfile = "multiple";
          };
          LE = {EnableAdvMonInterleaveScan = "true";};
        };
      };

      # services.blueman.enable = true;
    };
  }
