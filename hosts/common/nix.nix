{
  inputs,
  lib,
  pkgs,
  username,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      # git
      nvd
    ];
  };

  # @type {NixpkgsConfig}
  nix = {
    gc = {
      # automatic = lib.mkDefault true;
      dates = lib.mkDefault "19:00";
      persistent = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 10d";
    };

    settings = {
      trusted-users = lib.mkForce [
        "root"
        "@wheel"
        username
      ];
      substituters = [
        "https://cache.nixos.org/"
        "https://numtide.cachix.org"
        "https://nixpkgs-update.cachix.org"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://xonsh-xontribs.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-update.cachix.org-1:6y6Z2JdoL3APdu6/+Iy8eZX2ajf09e4EE9SnxSML1W8="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "xonsh-xontribs.cachix.org-1:LgP0Eb1miAJqjjhDvNafSrzBQ1HEtfNl39kKtgF5LBQ="
      ];
    };

    package = pkgs.nixFlakes;
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
  };

  programs = {
    bash = {
      shellInit = ''
        alias nix_package_size="nix path-info --size --human-readable --recursive /run/current-system | cut -d - -f 2- | sort"
      '';
      blesh.enable = true;
    };
  };

  system = {
    autoUpgrade.enable = lib.mkDefault false;
    stateVersion = lib.mkDefault "23.11";
  };
}
