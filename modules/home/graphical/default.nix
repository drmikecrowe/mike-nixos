{
  custom,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./kitty.nix
    ./obsidian.nix
    ./gtk.nix
    ./vscode
    ./wezterm.nix
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
