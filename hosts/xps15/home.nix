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
  imports = [
    ./xps15-home-packages.nix
  ];

  home = {
    file.".config/autostart/launch-copyq" = {
      text = ''
        #!/usr/bin/env bash

        if [ "$XDG_SESSION_TYPE" == "wayland" ]; then 
          export QT_QPA_PLATFORM=xcb
        fi
        nohup copyq --start-server hide > /tmp/copyq.log 2>&1 &
      '';
      executable = true;
    };
  };
}
