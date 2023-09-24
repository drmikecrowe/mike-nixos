{
  config,
  pkgs,
  lib,
  ...
}: let
  neovim = import ./package {
    inherit pkgs;
    inherit (config.theme) colors;
  };
in {
  options.neovim.enable = lib.mkEnableOption "Neovim.";

  config = lib.mkIf config.neovim.enable {
    home-manager.users.${config.user} = {
      programs.neovim.enable = true;
      programs.neovim.package = pkgs.neovim-unwrapped;

      programs.git.extraConfig.core.editor = "nvim";
      home.sessionVariables = {
        EDITOR = "nvim";
        MANPAGER = "nvim +Man!";
      };
      programs.fish = {
        shellAliases = {vim = "nvim";};
        shellAbbrs = {
          v = lib.mkForce "nvim";
          vl = lib.mkForce "nvim -c 'normal! `0' -c 'bdelete 1'";
          vll = "nvim -c 'Telescope oldfiles'";
        };
      };
      programs.kitty.settings.scrollback_pager =
        lib.mkForce ''
          ${neovim}/bin/nvim -c 'setlocal nonumber nolist showtabline=0 foldcolumn=0|Man!' -c "autocmd VimEnter * normal G" -'';

      xdg.desktopEntries.nvim = lib.mkIf pkgs.stdenv.isLinux {
        name = "Neovim wrapper";
        exec = "kitty nvim %F";
      };
      xdg.mimeApps.defaultApplications = lib.mkIf pkgs.stdenv.isLinux {
        "text/plain" = ["nvim.desktop"];
        "text/markdown" = ["nvim.desktop"];
      };
    };

    # # Used for icons in Vim
    # fonts.fonts = with pkgs; [ nerdfonts ];
  };
}
