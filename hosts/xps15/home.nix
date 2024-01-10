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
      peek
      appimage-run
      authy
      brave
      chatgpt-cli
      codeium
      bcompare
      copyq
      dbeaver
      discord
      element-desktop
      firefox
      flameshot
      gimp
      glxinfo
      gtk3
      gtk4
      kitty
      libreoffice
      meld
      albert
      obsidian
      pinentry-qt
      slack
      teams-for-linux
      vlc
      wavebox
      xdg-utils
      yubikey-manager
      yubikey-personalization-gui
      yubioath-flutter
      zoom-us
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
