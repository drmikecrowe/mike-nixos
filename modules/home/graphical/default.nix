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
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = [defaultBrowser];
        "application/xhtml+xml" = [defaultBrowser];
        "text/html" = [defaultBrowser];
        "x-scheme-handler/https" = [defaultBrowser];
        "image/gif" = [defaultBrowser];
        "image/png" = [defaultBrowser];
        "image/webp" = [defaultBrowser];
      };
      associations.added = {
        "x-scheme-handler/mailto" = defaultEmail;
        # others...
      };
    };
    configFile."mimeapps.list".force = true;

    mimeApps.defaultApplications = {
      "text/plain" = ["nvim.desktop"];
      "text/markdown" = ["nvim.desktop"];
    };

    desktopEntries = {
      "kitty-fish" = {
        name = "Fish (kitty)";
        genericName = "Terminal emulator";
        exec = "kitty fish -li";
        icon = "fish";
        categories = ["System" "TerminalEmulator" "Utility"];
        type = "Application";
        terminal = false;
      };
      "kitty-nushell" = {
        name = "Nushell (kitty)";
        genericName = "Terminal emulator";
        exec = "kitty nu -li";
        icon = "nushell";
        categories = ["System" "TerminalEmulator" "Utility"];
        type = "Application";
        terminal = false;
      };
      "nvim" = {
        name = "Neovim wrapper";
        exec = "kitty nvim %F";
      };
    };
  };
}
