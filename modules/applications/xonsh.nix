{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.xonsh;

  # https://github.com/t184256/nix-configs/blob/bf08416f7be5511d920a43d9bf2562b05605b0a9/user/xonsh/default.nix
  # TODO: https://github.com/NixOS/nixpkgs/issues/276326
  over-xonsh = pkgs.xonsh.override {
    extraPackages = ps: [
      ps.xontrib-xonsh-direnv
      ps.xontrib-readable-traceback
      ps.xontrib-dot-dot
      ps.xontrib-zoxide
      ps.xontrib-chatgpt
      ps.xontrib-prompt-starship
      ps.xontrib-gitinfo
      ps.xontrib-term-integrations
      ps.xontrib-clp
      ps.xontrib-sh
    ];
  };
  my-xonsh = pkgs.writeShellScriptBin "xonsh" ''
    XONSH=$(dirname $(dirname $(realpath ${over-xonsh}/bin/xonsh)))
    exec $XONSH/bin/python3 -u -m xonsh "$@"
  '';
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
    nixpkgs.overlays = [
      (import ../../overlays/xontribs)
      (self: super: {inherit my-xonsh;}) # I refer to it in user/tmux
    ];

    # This is the right way to pull in xonsh from my overlays.additions
    # nixpkgs.overlays = [ inputs.self.overlays.additions ];
    # systemPackages = with pkgs.additions; [ xonsh ];
    # We can do it like this too...
    environment.systemPackages = [
      my-xonsh
    ];
  };
}
