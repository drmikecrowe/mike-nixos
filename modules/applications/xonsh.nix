{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.xonsh;
in {
  options = {
    host.application.xonsh = {
      enable = lib.mkOption {
        default = false;
        type = with lib.types; bool;
        description = "Enables xonsh";
      };
    };
  };

  config = lib.mkIf (cfg.enable) {
    programs.xonsh = {
      enable = true;

      package = pkgs.xonsh.overrideAttrs (oldAttrs: {
        propagatedBuildInputs =
          oldAttrs.propagatedBuildInputs
          ++ (with config.nur.repos.xonsh-xontribs; [
            xontrib-chatgpt
            xontrib-clp
            xontrib-direnv
            xontrib-dot-dot
            xontrib-gitinfo
            xontrib-prompt-starship
            xontrib-readable-traceback
            xontrib-sh
            xontrib-term-integrations
            xontrib-zoxide
          ]);
      });
    };
  };
}
