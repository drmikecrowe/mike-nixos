{ config, pkgs, lib, ... }: {

  config = {
    home-manager.users.${config.user} = {

      programs.bash = { enable = true; };

      programs.starship.enableBashIntegration = false;
      programs.zoxide.enableBashIntegration = true;
      programs.fzf.enableBashIntegration = true;

    };
  };
}
