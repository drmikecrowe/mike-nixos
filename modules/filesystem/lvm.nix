{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.filesystem.lvm;
in
  with lib; {
    options = {
      host.filesystem.lvm = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables settings for a LVM";
        };
      };
    };

    config = mkIf cfg.enable {
      boot = {
        supportedFilesystems = [
          "ext4"
        ];
      };
    };
  }
