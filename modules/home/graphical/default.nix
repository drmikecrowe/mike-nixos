{
  custom,
  lib,
  pkgs,
  ...
}: let
  defaultBrowser = "firefox.desktop";
  defaultEmail = "Wavebox.desktop";
in {
  imports = [
    ./kitty.nix
    ./obsidian.nix
    ./vscode
  ];

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk2.extraConfig = ''
      gtk-enable-animations=1
      gtk-primary-button-warps-slider=0
      gtk-toolbar-style=3
      gtk-menu-images=1
      gtk-button-images=1
      gtk-cursor-theme-size=24
      gtk-font-name="NotoSans NF Med,  11"
      gtk-theme-name="palenight"
      gtk-cursor-theme-name="breeze_cursors"
      gtk-icon-theme-name="breeze-dark"
    '';

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name="breeze_cursors"
        gtk-icon-theme-name="breeze-dark"
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name="breeze_cursors"
        gtk-icon-theme-name="breeze-dark"
      '';
    };
  };

  home.sessionVariables.GTK_THEME = "palenight";

  xdg = {
    desktopEntries = {
      "nvim" = {
        name = "Neovim wrapper";
        exec = "wezterm start --cwd . %F";
      };
    };
  };
}
