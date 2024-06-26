{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.xonsh;
  # https://github.com/t184256/nix-configs/blob/bf08416f7be5511d920a43d9bf2562b05605b0a9/user/xonsh/default.nix
  # TODO: https://github.com/NixOS/nixpkgs/issues/276326
  xonshWithXontribs = pkgs.xonsh.overrideAttrs (oldAttrs: {
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
      package = xonshWithXontribs;
    };
  };
}
