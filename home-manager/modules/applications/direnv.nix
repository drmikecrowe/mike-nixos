{
  config,
  lib,
  ...
}: let
  cfg = config.host.home.applications.direnv;
in {
  options = {
    host.home.applications.direnv = {
      enable = lib.mkOption {
        default = false;
        type = with lib.types; bool;
        description = "Enables direnv";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        config.global.hide_env_diff = true;
        nix-direnv.enable = true;
        enableBashIntegration = true;
        # enableFishIntegration = true;
        enableNushellIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
