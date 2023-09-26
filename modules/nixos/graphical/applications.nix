{ config
, pkgs
, lib
, ...
}:
let
  autostartFolder = ".config/autostart/";
  profileFolder = ".nix-profile/share/applications/";
  autostartPrograms = [ "org.flameshot.Flameshot" ];
in
{
  config = lib.mkIf config.gui.enable {
    nix.allowedUnfree = [ "authy" "zoom" "microsoft-edge-stable" "obsidian" "vivaldi" "code" ];

    home-manager.users.${config.user} = {
      home = {
        packages = with pkgs; [
          appimage-run
          authy
          brave
          chatgpt-cli
          copyq
          element-desktop
          firefox
          flameshot
          glxinfo
          gtk3
          gtk4
          kitty
          libreoffice
          mailspring
          meld
          microsoft-edge
          obsidian
          # peek
          teams-for-linux
          yubikey-personalization-gui
          yubikey-manager
          yubioath-flutter
          xdg-utils
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
      };

      nixpkgs.config = {
        vivaldi = {
          proprietaryCodecs = true;
        };
      };

      # Nicely reload system units when changing configs
      systemd.user.startServices = "sd-switch";
    };
  };
}
