{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    home-manager.users.${config.user} = {
      programs.bash = {
        enable = true;
        historyControl = ["ignoredups" "ignorespace"];
      };

      programs.starship.enableBashIntegration = true;
      programs.zoxide.enableBashIntegration = true;
      programs.fzf.enableBashIntegration = true;
    };
  };
}
