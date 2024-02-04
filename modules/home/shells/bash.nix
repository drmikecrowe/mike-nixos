{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  programs = {
    bash = {
      enable = true;
      historyControl = ["ignoredups" "ignorespace"];
      bashrcExtra = ''

      '';
    };
    atuin = {
      enable = true;
      enableBashIntegration = true;
    };
    fzf.enableBashIntegration = true;
    starship.enableBashIntegration = true;
    zoxide.enableBashIntegration = true;
  };
}
