{
  inputs,
  config,
  lib,
  pkgs,
  dotfiles,
  specialArgs,
  ...
}: {
  config = {
    home = {
      packages = with pkgs; [
        inputs.devenv.packages.${system}.devenv
        (writeShellApplication {
          name = "rsyncFolder";
          text = ''
            touch "$2"
            rm -rf "$2"
            mkdir -p "$2"
            rsync -armR --info=progress2 --exclude='.esbuild' --exclude='.jest' --exclude='.history' --exclude='.pnpm-store' --exclude='node_modules/' --exclude='.tmp/' --exclude='.git/' --exclude='.webpack/' --exclude='.serverless/' --exclude='coverage/' "$@"
          '';
        })
        (writeShellApplication {
          name = "archive";
          text = ''
            set -e
            tar -czf "$1".tbz2 "$1"
            rm -rf "$1"
          '';
        })
        (writeShellApplication {
          name = "aws-pinnacle-data";
          text = ''
            CMD="$1"
            shift
            aws-sso -S pinnacle "$CMD" -p pinnacle-data "$@"
          '';
        })
        (writeShellApplication {
          name = "aws-pinnacle-dev";
          text = ''
            CMD="$1"
            shift
            aws-sso -S pinnacle "$CMD" -p pinnacle-dev "$@"
          '';
        })
        (writeShellApplication {
          name = "aws-pinnacle-prod";
          text = ''
            CMD="$1"
            shift
            aws-sso -S pinnacle "$CMD" -p pinnacle-prod "$@"
          '';
        })
        (writeShellApplication {
          name = "aws-pinnacle-mike";
          text = ''
            CMD="$1"
            shift
            aws-sso -S pinnacle "$CMD" -p pinnacle-mike "$@"
          '';
        })
        (writeShellApplication {
          name = "aws-pinnacle-root";
          text = ''
            CMD="$1"
            shift
            aws-sso -S pinnacle "$CMD" -p pinnacle-root "$@"
          '';
        })
        # personal-mike-AdministratorAccess
        (writeShellApplication {
          name = "aws-personal-mike";
          text = ''
            CMD="$1"
            shift
            aws-sso -S personal "$CMD" -p personal-mike-AdministratorAccess "$@"
          '';
        })
      ];
    };
  };
}
