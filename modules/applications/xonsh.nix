{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.nur.repos) xonsh-xontribs;
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
    programs.xonsh = with xonsh-xontribs; {
      enable = true;
      package = xonsh-wrapped.override {
        xonsh = xonsh;
        extraPackages = ps: [
          xonsh
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
        ];
      };
    };
  };
}
