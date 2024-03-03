{
  config,
  lib,
  pkgs,
  ...
}: let
  kibibyte = 1024;
  mibibyte = 1024 * kibibyte;
  gibibyte = 1024 * mibibyte;
in {
  config = lib.mkMerge [
    {
      nix = {
        # Enable features in Nix commands
        extraOptions = ''
          experimental-features = nix-command flakes
          warn-dirty = false
        '';

        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };

        settings = {
          max-jobs = lib.mkDefault 12;
          trusted-users = lib.mkDefault ["root" "@wheel"];
          min-free = lib.mkDefault (5 * gibibyte);
          max-free = lib.mkDefault (25 * gibibyte);
          # Add community Cachix to binary cache
          # Don't use with macOS because blocked by corporate firewall
          builders-use-substitutes = true;
          substituters =
            lib.mkIf (!pkgs.stdenv.isDarwin)
            ["https://nix-community.cachix.org"];
          trusted-public-keys = lib.mkIf (!pkgs.stdenv.isDarwin) [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];

          # Scans and hard links identical files in the store
          # Not working with macOS: https://github.com/NixOS/nix/issues/7273
          auto-optimise-store = lib.mkIf (!pkgs.stdenv.isDarwin) true;
        };
      };
    }
    {
      systemd.timers.nix-gc.timerConfig = {WakeSystem = true;};
      systemd.services.nix-gc.unitConfig.ConditionACPower = true;
    }
  ];
}
