{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.carapace;
in {
  options = {
    host.home.applications.carapace = {
      enable = lib.mkOption {
        default = false;
        type = with lib.types; bool;
        description = "Enables carapace";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        carapace
      ];
    };
    programs = {
      bash = {
        initExtra = ''
          source <(carapace _carapace)
        '';
      };
    };
  };
}
