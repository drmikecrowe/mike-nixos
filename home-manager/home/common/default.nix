{
  config,
  inputs,
  lib,
  pkgs,
  specialArgs,
  ...
}: let
  if-exists = f: builtins.pathExists f;
  existing-imports = imports: builtins.filter if-exists imports;
  inherit (specialArgs) role username desktopEnvironment;
in
  with lib; {
    imports =
      [
        ./home-manager.nix
        ./locale.nix
        ./nix.nix
      ]
      ++ existing-imports [
        ./role/${role}
        ./role/${role}.nix
      ];

    host = {
      home = {
        users = {
          enabled = [username];
        };
        applications = {
          argc-completions.enable = mkDefault true;
          atuin.enable = mkDefault true;
          awscli2.enable = mkDefault true;
          bash.enable = mkDefault true;
          chatblade.enable = mkDefault true;
          direnv.enable = mkDefault true;
          dua.enable = mkDefault true;
          eza.enable = mkDefault true;
          fd.enable = mkDefault true;
          fish.enable = mkDefault true;
          github.enable = mkDefault true;
          git.enable = mkDefault true;
          gnumake.enable = mkDefault true;
          htmlq.enable = mkDefault true;
          htop.enable = mkDefault true;
          jq.enable = mkDefault true;
          mc.enable = mkDefault true;
          neovim.enable = mkDefault true;
          nushell.enable = mkDefault true;
          ouch.enable = mkDefault true;
          ripgrep.enable = mkDefault true;
          rsync.enable = mkDefault true;
          tmux.enable = mkDefault true;
          tree.enable = mkDefault true;
          unzip.enable = mkDefault true;
          xonsh.enable = mkDefault true;
          yazi.enable = mkDefault true;
          yq-go.enable = mkDefault true;
          zoxide.enable = mkDefault true;
          zsh.enable = mkDefault true;
        };
        feature = {
        };
      };
    };

    home = {
      packages = with pkgs; (lib.optionals pkgs.stdenv.isLinux
        [
          psmisc
          strace
        ]);
    };
  }
