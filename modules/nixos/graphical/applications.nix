{ config, pkgs, lib, ... }:
let
  autostartFolder = ".config/autostart/";
  profileFolder = ".nix-profile/share/applications/";
  autostartPrograms =
    [ "com.github.hluk.copyq" "org.flameshot.Flameshot" "1password" ];
in
{

  config = lib.mkIf config.gui.enable {

    home-manager.users.${config.user} = {
      home = {
        packages = with pkgs; [
          appimage-run
          authy
          copyq
          discord
          firefox
          flameshot
          glxinfo
          gtk3
          gtk4
          kitty
          libreoffice
          meld
          obsidian
          peek
          rnix-lsp
          virt-manager
          vivaldi
          vscode
          yubikey-personalization-gui
          yubikey-manager
          yubioath-flutter
          zoom-us
        ];
      };

      home.file.".config/autostart/1password-startup.desktop".source =
        ./autostart/1password-startup.desktop;
      home.file.".config/autostart/copyq-startup.desktop".source =
        ./autostart/copyq-startup.desktop;

      programs = { keychain.enable = true; };

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
