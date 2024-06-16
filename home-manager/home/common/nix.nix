{
  inputs,
  lib,
  pkgs,
  ...
}: {
  home = {
    activation = {
      report-changes = ''
        PATH=$PATH:${lib.makeBinPath [pkgs.nvd pkgs.nix pkgs.python3Full]}
        python /home/mcrowe/bin/report-changes.py
      '';
    };
  };

  nix = {
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = lib.mkDefault false;
    };

    # package = pkgs.nixFlakes;
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
  };

  nixpkgs = {
    config = {
      allowUnfree = lib.mkDefault true;
      allowUnfreePredicate = _: true;
    };
  };

  programs = {
    bash = {
      initExtra = ''
        if [ -f "$XDG_RUNTIME_DIR"/secrets/gh_token ] ; then
            export NIX_CONFIG="access-tokens = github.com=$(cat $XDG_RUNTIME_DIR/secrets/gh_token)"
        fi
      '';
    };

    nix-index = {
      enable = lib.mkDefault true;
      enableBashIntegration = lib.mkDefault true;
    };
  };
}
