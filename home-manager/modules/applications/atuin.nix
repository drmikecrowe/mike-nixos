{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.atuin;
in {
  options = {
    host.home.applications.atuin = {
      enable = lib.mkOption {
        default = false;
        type = with lib.types; bool;
        description = "Enables atuin";
      };
    };
  };

  config = lib.mkIf cfg.enable {
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
