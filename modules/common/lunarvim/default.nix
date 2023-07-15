{ config, pkgs, lib, ... }:

let

  lvim = pkgs.callPackage ./package.nix {
    configHome = "~/.config/lvim";
    dataHome = "~/.local/share/lvim";
    cacheHome = "~/.cache/lvim";
  };

in
{

  options.lunarvim.enable = lib.mkEnableOption "Enable lunarvim.";

  config = lib.mkIf config.lunarvim.enable {
    home-manager.users.${config.user} = {

      home.packages = [ lvim ];

      home.file.".config/.lvim" = {
        enable = true;
        source =
          ./config;
      };

      home.sessionVariables = {
        EDITOR = "lvim";
        MANPAGER = "lvim +Man!";
      };

      programs.fish = {
        shellAliases = { vim = "lvim"; };
        shellAbbrs = {
          v = lib.mkForce "lvim";
          vl = lib.mkForce "lvim -c 'normal! `0' -c 'bdelete 1'";
          vll = "lvim -c 'Telescope oldfiles'";
        };
      };

      programs.kitty.settings.scrollback_pager = lib.mkForce ''
        ${lvim}/bin/lvim -c 'setlocal nonumber nolist showtabline=0 foldcolumn=0|Man!' -c "autocmd VimEnter * normal G" -'';

      xdg.desktopEntries.lvim = lib.mkIf pkgs.stdenv.isLinux {
        name = "lunarvim wrapper";
        exec = "kitty lvim %F";
      };

      xdg.mimeApps.defaultApplications = lib.mkIf pkgs.stdenv.isLinux {
        "text/plain" = [ "lvim.desktop" ];
        "text/markdown" = [ "lvim.desktop" ];
      };

    };

  };

}
