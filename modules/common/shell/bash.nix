{ config, pkgs, lib, ... }: {

  config = {
    home-manager.users.${config.user} = {

      programs.bash = { enable = true; };

      programs.starship.enableBashIntegration = true;
      programs.zoxide.enableBashIntegration = true;
      programs.fzf.enableBashIntegration = true;

    };
  };
}
