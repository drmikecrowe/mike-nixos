{ config
, dotfiles
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    discord
    slack
  ];

  home.file.".config/discord/settings.json".text = builtins.readFile "${dotfiles}/discord/settings.json";
}
