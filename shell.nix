# Shell for bootstrapping flake-enabled nix and home-manager
# You can enter it through 'nix develop' or (legacy) 'nix-shell'
{pkgs ? (import ./nixpkgs.nix) {}}: {
  default = pkgs.mkShell {
    # Enable experimental features without having to specify the argument
    NIX_CONFIG = "experimental-features = nix-command flakes";
    name = "flake-shell";
    buildInputs = with pkgs; [
      git
      git-crypt
      stylua
      alejandra
      shfmt
      shellcheck
      statix
      nvd
      nix-prefetch
      nix-prefetch-scripts
      nix-tree
      nixd
      nil
      nh
      neovim
      # vscodium-fhs
      # nixd
      ripgrep
      docker-compose-language-service
      dockerfile-language-server-nodejs
      lazygit
      bash-language-server
      nodePackages_latest.vscode-json-languageserver
      nodePackages_latest.prettier
      yaml-language-server

      shellcheck
      shfmt

      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-fzf-commands
      vimPlugins.nvim-fzf
      tree-sitter
    ];
  };
}
