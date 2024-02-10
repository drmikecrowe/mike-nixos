{
  config,
  pkgs,
  lib,
  user,
  dotfiles,
  ...
}: {
  home.file.".config/nushell/config.toml".source = "${dotfiles}/nushell/config.toml";
  home.file.".config/nushell/conf.d".source = "${dotfiles}/nushell/conf.d";
  programs = {
    nushell = {
      enable = true;
    };
  };
}
