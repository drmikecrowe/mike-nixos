{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.atuin;
in
  with lib; {
    options = {
      host.home.applications.atuin = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables atuin";
        };
      };
    };

    config = mkIf cfg.enable {
      programs = {
        atuin = {
          enable = true;
          enableBashIntegration = true;
          enableFishIntegration = true;
          enableNushellIntegration = true;
          enableZshIntegration = true;
          package = pkgs.atuin;
          flags = ["--disable-up-arrow"];
        };
      };
    };
  }
