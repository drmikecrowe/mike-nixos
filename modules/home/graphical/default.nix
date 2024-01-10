{ custom
, lib
, pkgs
, ...
}:
let
  defaultBrowser = "firefox.desktop";
  defaultEmail = "Wavebox.desktop";
in
{
  imports = [
    ./kitty.nix
    ./obsidian.nix
    ./vscode
  ];

  gtk =
    let
      gtkExtraConfig = {
        gtk-application-prefer-dark-theme =
          if custom.theme.dark
          then "true"
          else "false";
      };
    in
    {
      enable = true;
      # theme = gtkTheme;
      gtk3.extraConfig = gtkExtraConfig;
      gtk4.extraConfig = gtkExtraConfig;
    };

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = [ defaultBrowser ];
        "application/xhtml+xml" = [ defaultBrowser ];
        "text/html" = [ defaultBrowser ];
        "x-scheme-handler/https" = [ defaultBrowser ];
        "image/gif" = [ defaultBrowser ];
        "image/png" = [ defaultBrowser ];
        "image/webp" = [ defaultBrowser ];
      };
      associations.added = {
        "x-scheme-handler/mailto" = defaultEmail;
        # others...
      };
    };
    configFile."mimeapps.list".force = true;

    mimeApps.defaultApplications = {
      "text/plain" = [ "nvim.desktop" ];
      "text/markdown" = [ "nvim.desktop" ];
    };

    desktopEntries = {
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
        name = "Nushell (kitty)";
        genericName = "Terminal emulator";
        exec = "kitty nu -li";
        icon = "nushell";
        categories = [ "System" "TerminalEmulator" "Utility" ];
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
