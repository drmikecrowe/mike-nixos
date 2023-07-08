{ inputs, outputs, lib, config, pkgs, ... }:
let
  autostartFolder = ".config/autostart/";
  profileFolder = ".nix-profile/share/applications/";
  autostartPrograms = [ "com.github.hluk.copyq" "org.flameshot.Flameshot" ];
in
{
  imports = [
    ./dconf.nix
    ./wezterm.nix
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
    direnv.nix-direnv.enable = true;
  };

  xdg.desktopEntries = {
    "com.github.hluk.copyq-wayland" = {
      name = "CopyQ";
      genericName = "Clipboard Manager";
      exec = "/bin/sh -c \"export QT_QPA_PLATFORM=xcb && ${pkgs.copyq}/bin/copyq --start-server hide\"";
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
    "wezterm-fish" = {
      name = "Fish (wezterm)";
      genericName = "Terminal emulator";
      exec = "wezterm start fish -li";
      icon = "fish";
      categories = [ "System" "TerminalEmulator" "Utility" ];
      type = "Application";
      terminal = false;
    };
    "wezterm-nushell" = {
      name = "Nu Shell (wezterm)";
      genericName = "Terminal emulator";
      exec = "wezterm start nu -li";
      icon = "nushell-original";
      categories = [ "System" "TerminalEmulator" "Utility" ];
      type = "Application";
      terminal = false;
    };
  };
}
