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

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
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
