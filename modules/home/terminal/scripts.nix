{ config
, pkgs
, lib
, ...
}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "rsyncFolder";
      text = ''
        mkdir -p "$2"
        rsync -avrmR --exclude='.esbuild' --exclude='.jest' --exclude='.history' --exclude='.pnpm-store' --exclude='node_modules/' --exclude='.tmp/' --exclude='.git/' --exclude='.webpack/' --exclude='.serverless/' --exclude='coverage/' "$@"
      '';
    })
    (pkgs.writeShellApplication {
      name = "mkcd";
      text = ''
        [ -n "$1" ] && mkdir -p "$1"
        cd "$1"
      '';
    })
  ];
}
