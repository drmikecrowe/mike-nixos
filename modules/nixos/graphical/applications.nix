{ config, pkgs, lib, ... }:
let
  autostartFolder = ".config/autostart/";
  profileFolder = ".nix-profile/share/applications/";
  autostartPrograms =
    [ "com.github.hluk.copyq" "org.flameshot.Flameshot" "1password" ];
in
{
  config = lib.mkIf config.gui.enable {

    home-manager.users.${config.user} =
      {
        home = {
          packages = with pkgs; [
            appimage-run
            # authy
            bluemail
            chatgpt-cli
            copyq
            electron
            google-chrome
            discord
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
            rnix-lsp
            teams-for-linux
            vscode
            yubikey-personalization-gui
            yubikey-manager
            yubioath-flutter
            vivaldi
            vivaldi-ffmpeg-codecs
            zoom-us
          ];

          file."bin/launch-copyq" = {
            text = ''
              #!/usr/bin/env bash 

              if [[ "$WAYLAND_DISPLAY" == "wayland-0" ]]; then
                  echo "Wayland detected, using wayland backend"
                  export QT_QPA_PLATFORM=xcb
              fi
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

        xdg.configFile."mimeapps.list".force = true;
        xdg.mimeApps = {
          enable = true;
          defaultApplications = {
            "x-scheme-handler/http" = [ "microsoft-edge.desktop;" ];
            "application/xhtml+xml" = [ "microsoft-edge.desktop;" ];
            "text/html" = [ "microsoft-edge.desktop;" ];
            "x-scheme-handler/https" = [ "microsoft-edge.desktop;" ];
            "image/gif" = [ "microsoft-edge.desktop;" ];
            "image/png" = [ "microsoft-edge.desktop;" ];
            "image/webp" = [ "microsoft-edge.desktop;" ];
          };
          associations.added = {
            "x-scheme-handler/mailto" = "thunderbird.desktop";
            # others...
          };
        };

        # Nicely reload system units when changing configs
        systemd.user.startServices = "sd-switch";

        xdg.desktopEntries = {
          "wavebox" = {
            categories = [ "Network" "WebBrowser" ];
            exec = "appimage-run /home/mcrowe/bin/Wavebox.AppImage";
            genericName = "Wavebox";
            icon = "wavebox";
            name = "Wavebox";
          };
        };
      };

  };

}
