{
  config,
  lib,
  dotfiles,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.neovim;
in
  with lib; {
    options = {
      host.home.applications.neovim = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables neovim";
        };
      };
    };

    config = mkIf cfg.enable {
      programs.neovim = {
        enable = true;
        vimAlias = true;
        package = pkgs.neovim-unwrapped;
      };

      home.packages = with pkgs; [
        # TODO: Make these a config set somehow
        docker-compose-language-service
        dockerfile-language-server-nodejs
        lazygit
        luajitPackages.luacheck
        lua-language-server # lua lsp
        nixd
        nodePackages_latest.bash-language-server
        nodePackages_latest.pyright # Python language server
        nodePackages_latest.svelte-language-server
        nodePackages_latest.typescript-language-server
        nodePackages_latest.vscode-json-languageserver
        nodePackages_latest.prettier
        tailwindcss-language-server
        terraform-lsp
        yaml-language-server

        shellcheck
        shfmt
        stylua
        terraform-ls

        vimPlugins.nvim-treesitter.withAllGrammars
        tree-sitter
      ];

      programs.git.extraConfig.core.editor = "nvim";

      home = {
        shellAliases = {
          lg = "lazygit";
        };

        sessionVariables = {
          EDITOR = "nvim";
          MANPAGER = "nvim +Man!";
        };
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
          ${pkgs.neovim}/bin/nvim -c 'setlocal nonumber nolist showtabline=0 foldcolumn=0|Man!' -c "autocmd VimEnter * normal G" -'';
    };
  }
