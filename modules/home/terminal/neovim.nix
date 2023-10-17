{ config
, inputs
, pkgs
, lib
, dotfiles
, ...
}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    package = pkgs.neovim-unwrapped;
  };

  home.packages = with pkgs; [
    lazygit
    rnix-lsp
    terraform-lsp

    yaml-language-server
    python311Packages.python-lsp-server # python lsp
    sumneko-lua-language-server # lua lsp
    nodePackages_latest.typescript-language-server
    nodePackages_latest.bash-language-server

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

    file = {
      ".config/lazygit/config.yml".source = "${dotfiles}/nvim/lazygit.yml";
      ".config/nvim/lua/astronvim/options.lua".source = "${dotfiles}/nvim/options.lua";
      ".config/nvim" = {
        recursive = true;
        source = pkgs.fetchFromGitHub {
          owner = "AstroNvim";
          repo = "AstroNvim";
          rev = "v3.33.4";
          sha256 = "sha256-utGG1U9p3a5ynRcQys1OuD5J0LjkIQipD0TX8zW66/4=";
        };
      };
      ".config/nvim/lua/user/" = {
        recursive = true;
        source = "${dotfiles}/nvim/astronvim";
      };
    };

    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    };
  };

  programs.fish = {
    shellAliases = { vim = "nvim"; };
    shellAbbrs = {
      v = lib.mkForce "nvim";
      vl = lib.mkForce "nvim -c 'normal! `0' -c 'bdelete 1'";
      vll = "nvim -c 'Telescope oldfiles'";
    };
  };

  programs.kitty.settings.scrollback_pager =
    lib.mkForce ''
      ${pkgs.neovim}/bin/nvim -c 'setlocal nonumber nolist showtabline=0 foldcolumn=0|Man!' -c "autocmd VimEnter * normal G" -'';
}
