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
      authy
      copyq
      firefox
      flameshot
      kitty
      libreoffice
      meld
      obsidian
      peek
      rnix-lsp
      teams
      vscode
      virt-manager
      vivaldi
      xclip
      yubikey-personalization-gui
      yubioath-flutter
      appimage-run
      wavebox
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
  };
}
