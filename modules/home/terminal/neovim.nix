{
  config,
  inputs,
  pkgs,
  lib,
  dotfiles,
  ...
}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    package = pkgs.neovim-unwrapped;
  };

  home.packages = with pkgs; [
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

    file = {
      ".config/lazygit/config.yml".source = "${dotfiles}/nvim/lazygit.yml";
      ".config/nvim" = {
        recursive = true;
        source = pkgs.fetchFromGitHub {
          owner = "AstroNvim";
          repo = "AstroNvim";
          rev = "v3.43.3";
          sha256 = "sha256-bhTYKPNRNgxQdgXuFkooGuv7sTGpb7UHBb6M5HYZ4/A=";
        };
      };
      # ".config/nvim/lua/user/" = {
      #   recursive = true;
      #   source = "${dotfiles}/nvim/astronvim";
      # };
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
}
