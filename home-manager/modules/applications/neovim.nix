{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.neovim;
in {
  options = {
    host.home.applications.neovim = {
      enable = lib.mkOption {
        default = false;
        type = with lib.types; bool;
        description = "Enables neovim";
      };
    };
  };

  # THANKS TO https://github.com/redxtech/nixfiles/blob/451a94eeffd53de7e695cb525f6b1fb88e2279b8/modules/home-manager/cli/neovim.nix#L20
  config = lib.mkIf cfg.enable {
    programs = {
      neovim = {
        enable = true;

        # package = pkgs.neovim-nightly;

        withNodeJs = true;
        withPython3 = true;

        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        extraPackages = with pkgs; [
          nil

          # for nix-reaver
          nurl

          # for fugit2
          libgit2
          gpgme
          lua5_1
          lua51Packages.luarocks
        ];

        extraWrapperArgs = [
          "--prefix"
          "LD_LIBRARY_PATH"
          ":"
          "${lib.makeLibraryPath [pkgs.libgit2 pkgs.sqlite]}"
        ];
      };

      lsp = {
        enable = lib.mkDefault true;

        web.deno = true;
        terraform.enable = true;
      };

      git.extraConfig.core.editor = "nvim";

      fish = {
        shellAliases = {vim = "nvim";};
        shellAbbrs = {
          v = lib.mkForce "nvim";
          vl = lib.mkForce "nvim -c 'normal! `0' -c 'bdelete 1'";
          vll = "nvim -c 'Telescope oldfiles'";
        };
      };
    };

    home = {
      shellAliases = {
        lg = "lazygit";
      };

      sessionVariables = {
        EDITOR = "nvim";
        MANPAGER = "nvim +Man!";
      };
    };
  };
}
