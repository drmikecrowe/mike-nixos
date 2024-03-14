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

      # fileSystems = {
      #   "/".options = ["subvol=root" "compress=zstd" "noatime"];
      #   "/home".options = ["subvol=home/active" "compress=zstd" "noatime"];
      #   "/nix".options = ["subvol=nix" "compress=zstd" "noatime"];
      #   "/var".options = ["subvol=var_local/active" "compress=zstd" "noatime"];
      #   "/opt".options = ["subvol=var_log" "compress=zstd" "noatime"];
      # };
    };
  }
