{ config
, dotfiles
, pkgs
, ...
}: {
  home.packages = with pkgs; [
    discord
    slack
    pinentry-qt
  ];

  home.file.".config/discord/settings.json".text = builtins.readFile "${dotfiles}/discord/settings.json";
}
