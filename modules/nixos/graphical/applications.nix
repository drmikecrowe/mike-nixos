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
          chatgpt-cli
          copyq
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
          obsidian
          peek
          rnix-lsp
          teams-for-linux
          virt-manager
          vscode
          yubikey-personalization-gui
          yubikey-manager
          yubioath-flutter
          zoom-us
        ];
      };

      xdg.mimeApps.defaultApplications = lib.mkIf pkgs.stdenv.isLinux {
        "text/plain" = [ "nvim.desktop" ];
        "text/markdown" = [ "nvim.desktop" ];
        "x-scheme-handler/element" = [ "element-desktop.desktop" ];
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
