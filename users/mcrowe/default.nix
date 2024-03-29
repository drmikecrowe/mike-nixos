{
  config,
  lib,
  secrets,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  cfg_docker = config.host.feature.virtualization.docker;
  cfg_virtd = config.host.feature.virtualization.virtd.client;
  docker_groups =
    if cfg_docker.enable
    then ["docker"]
    else [];
  virtd_groups =
    if cfg_virtd.enable
    then ["libvirtd"]
    else [];
in
  with lib; {
    options = {
      host.user.mcrowe = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enable mcrowe user";
        };
      };
    };

    config = mkIf config.host.user.mcrowe.enable {
      host = {
        feature = {
          virtualization = {
            flatpak = {
              enable = true;
            };
          };
        };
      };
      users.users.mcrowe = {
        inherit (secrets.mcrowe) hashedPassword;
        isNormalUser = true;
        shell = pkgs.bashInteractive;
        uid = 1000;
        group = "users";
        extraGroups =
          [
            "wheel"
            "video"
            "audio"
            "bluetooth"
            "networkmanager"
          ]
          ++ docker_groups
          ++ virtd_groups
          ++ ifTheyExist [
            "git"
            "input"
            "lp"
            "mysql"
            "network"
          ];
      };
    };
  }
