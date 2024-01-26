{ config
, pkgs
, lib
, user
, dotfiles
, ...
}: {
  programs = {
    nushell = {
      enable = true;
      extraConfig = builtins.readFile "${dotfiles}/atuin/init.nu";
    };
    fzf.enableBashIntegration = true;
    starship.enableBashIntegration = true;
    zoxide.enableBashIntegration = true;
  };
}
