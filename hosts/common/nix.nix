{
  inputs,
  lib,
  pkgs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      git
      nvd
    ];
  };

  nix = {
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "19:00";
      persistent = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 10d";
    };

    settings = {
      accept-flake-config = lib.mkDefault true;
      auto-optimise-store = lib.mkDefault true;
      experimental-features = lib.mkDefault ["nix-command" "flakes" "repl-flake"];
      # show more log lines for failed builds
      log-lines = lib.mkDefault 30;
      # Free up to 10GiB whenever there is less than 5GB left.
      # this setting is in bytes, so we multiply with 1024 thrice
      min-free = lib.mkDefault "${toString (5 * 1024 * 1024 * 1024)}";
      max-free = lib.mkDefault "${toString (10 * 1024 * 1024 * 1024)}";
      max-jobs = lib.mkDefault "auto";
      trusted-users = lib.mkDefault ["root" "@wheel"];
      warn-dirty = lib.mkDefault false;
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
    activationScripts = {
      binbash = {
        deps = ["binsh"];
        text = ''
          ln -sf /bin/sh /bin/bash
        '';
      };
      report-changes = ''
        PATH=$PATH:${lib.makeBinPath [pkgs.nvd pkgs.nix pkgs.python311Full]}
        python /home/mcrowe/bin/report-changes.py
      '';
    };
    autoUpgrade.enable = lib.mkDefault false;
    stateVersion = lib.mkDefault "23.11";
  };
}
