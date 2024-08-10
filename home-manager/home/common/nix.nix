{
  inputs,
  lib,
  config,
  secrets,
  ...
}: {
  nix = {
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = lib.mkDefault false;
      access-tokens = "github.com=${secrets.github.api-token}";
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
