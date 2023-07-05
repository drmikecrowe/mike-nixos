{ inputs, outputs, lib, config, pkgs, ... }:
let
  autostartFolder = ".config/autostart/";
  profileFolder = ".nix-profile/share/applications/";
  autostartPrograms = [ "com.github.hluk.copyq" "org.flameshot.Flameshot" "teams" ];
in
{
  imports = [
    ./dconf.nix
  ];

  home = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      appimage-run
      authy
      copyq
      discord
      firefox
      flameshot
      kitty
      libreoffice
      meld
      obsidian
      peek
      rnix-lsp
      teams
      virt-manager
      vivaldi
      vscode
      xclip
      yubikey-personalization-gui
      yubioath-flutter
      zoom-us
    ];
    shellAliases = {
      pbcopy = "xclip -selection clipboard";
    };
  };

  home.file = builtins.listToAttrs
    (map
      (pkg:
        {
          name = "${autostartFolder}" + pkg + ".desktop";
          value =
            {
              source = config.home.homeDirectory + "/" + profileFolder + "/" + pkg + ".desktop";
            };
        })
      autostartPrograms);

  programs = {
    keychain.enable = true;
  };

  xdg.desktopEntries = {
    "com.github.hluk.copyq" = {
      name = "CopyQ";
      genericName = "Clipboard Manager";
      exec = "/bin/sh -c \"export QT_QPA_PLATFORM=xcb && ${pkgs.copyq}/copyq --start-server hide\"";
      terminal = false;
      categories = [ "Qt" "KDE" "Utility" ];
      mimeType = [ "text/html" "text/xml" ];
      comment = "A cut & paste history utility";
      settings = {
        X-KDE-autostart-after = "panel";
        X-KDE-StartupNotify = "false";
        X-KDE-UniqueApplet = "true";
      };
    };
    "wavebox" = {
      categories = [ "Network" "WebBrowser" ];
      exec = "appimage-run /home/mcrowe/bin/Wavebox.AppImage";
      genericName = "Wavebox";
      icon = "wavebox";
      name = "Wavebox";
    };
  };
}
