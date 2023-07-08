{ inputs, outputs, lib, config, pkgs, ... }:
let
  autostartFolder = ".config/autostart/";
  profileFolder = ".nix-profile/share/applications/";
  autostartPrograms = [ "com.github.hluk.copyq" "org.flameshot.Flameshot" "1password" ];
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
      gnome.gnome-themes-extra
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
      xclip
      yubikey-personalization-gui
      yubioath-flutter
      zoom-us
    ];
    shellAliases = {
      pbcopy = "xclip -selection clipboard";
    };
  };

  home.file.".config/autostart/1password-startup.desktop".source = ./autostart/1password-startup.desktop;
  home.file.".config/autostart/copyq-startup.desktop".source = ./autostart/copyq-startup.desktop;

  programs = {
    keychain.enable = true;
    direnv.nix-direnv.enable = true;
  };

  xdg.desktopEntries = {
    "wavebox" = {
      categories = [ "Network" "WebBrowser" ];
      exec = "appimage-run /home/mcrowe/bin/Wavebox.AppImage";
      genericName = "Wavebox";
      icon = "wavebox";
      name = "Wavebox";
    };
    "kitty-fish" = {
      name = "Fish (kitty)";
      genericName = "Terminal emulator";
      exec = "kitty fish -li";
      icon = "fish";
      categories = [ "System" "TerminalEmulator" "Utility" ];
      type = "Application";
      terminal = false;
    };
    "kitty-nushell" = {
      name = "Nu Shell (kitty)";
      genericName = "Terminal emulator";
      exec = "kitty start nu -li";
      icon = "nushell-original";
      categories = [ "System" "TerminalEmulator" "Utility" ];
      type = "Application";
      terminal = false;
    };
  };
}
