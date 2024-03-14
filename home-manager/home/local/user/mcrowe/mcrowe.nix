{
  inputs,
  config,
  lib,
  pkgs,
  dotfiles,
  specialArgs,
  ...
}:
with lib; {
  config = {
    home = {
      packages = with pkgs; [
        inputs.devenv.packages.${pkgs.system}.devenv
        (pkgs.writeShellApplication {
          name = "rsyncFolder";
          text = ''
            touch "$2"
            rm -rf "$2"
            mkdir -p "$2"
            rsync -armR --info=progress2 --exclude='.esbuild' --exclude='.jest' --exclude='.history' --exclude='.pnpm-store' --exclude='node_modules/' --exclude='.tmp/' --exclude='.git/' --exclude='.webpack/' --exclude='.serverless/' --exclude='coverage/' "$@"
          '';
        })
        (pkgs.writeShellApplication {
          name = "archive";
          text = ''
            set -e
            tar -czf "$1".tbz2 "$1"
            rm -rf "$1"
          '';
        })
      ];

      file = {
        ".rgignore".text = builtins.readFile "${dotfiles}/ignore.txt";
        ".fdignore".text = builtins.readFile "${dotfiles}/ignore.txt";
        ".digrc".text = "+noall +answer"; # Cleaner dig commands
      };
    };
  };
}
