{ config, pkgs, lib, ... }: {

  home-manager.users.${config.user}.home = {

    packages = [
      (pkgs.writeShellApplication {
        name = "rsyncFolder";
        text = ''
          mkdir -p "$2"
          rsync -avrmR --exclude='.history' --exclude='node_modules/' --exclude='.tmp/' --exclude='.git/' --exclude='.webpack/' --exclude='.serverless/' --exclude='coverage/' "$@"
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
  };
}
