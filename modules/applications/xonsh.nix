{
  config,
  lib,
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
    programs.xonsh = {
      enable = true;
      package = xonsh-xontribs.xonsh.override {
        extraPackages = ps: (with xonsh-xontribs; [
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
      };
    };
  };
}
