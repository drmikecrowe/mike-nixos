{ config
, dotfiles
, pkgs
, lib
, user
, ...
}:
let
  autostartFolder = ".config/autostart/";
  profileFolder = ".nix-profile/share/applications/";
  autostartPrograms = [ "org.flameshot.Flameshot" ];
in
{
  home = {
    packages = with pkgs; [
      authy
      copyq
      kitty
      albert
      pinentry-qt
      vlc
      xdg-utils
    ];

    file.".config/autostart/launch-copyq" = {
      text = ''
        #!/usr/bin/env bash

        export QT_QPA_PLATFORM=xcb
        nohup copyq --start-server hide > /tmp/copyq.log 2>&1 &
      '';
      executable = true;
    };
    file.".config/discord/settings.json".text = builtins.readFile "${dotfiles}/discord/settings.json";
  };
}