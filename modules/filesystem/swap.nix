{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.filesystem.swap;
  swap_location =
    if cfg.type == "file"
    then cfg.file
    else "/dev/" + cfg.partition;
in
  with lib; {
    options = {
      host.filesystem.swap = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enable Swap";
        };
        type = mkOption {
          default = null;
          type = types.enum ["file" "partition"];
          description = "Swap Type";
        };
        encrypt = mkOption {
          default = true;
          type = with types; bool;
          description = "Perform random encryption";
        };
        file = mkOption {
          default = "/swap/swapfile";
          type = with types; str;
          description = "Location of Swapfile";
        };
        partition = mkOption {
          default = null;
          type = with types; str;
          example = "sda2";
          description = "Partition to be used for swap";
        };
        size = mkOption {
          type = with types; int;
          default = 8192;
          description = "Size in Megabytes";
        };
      };
    };

    config = mkMerge [
      (mkIf ((cfg.enable) && (cfg.type == "file")) {
        swapDevices = [
          {
            device = swap_location;
            size = 2048; #cfg.size;
          }
        ];
      })

      (mkIf ((cfg.enable) && (cfg.type == "partition")) {
        swapDevices = [
          {
            device = swap_location;
            randomEncryption.enable = false;
          }
        ];
      })
    ];
  }
