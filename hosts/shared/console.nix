{ pkgs, ... }:
{
  environment.variables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        set nocompatible
        filetype off
        syntax on
        filetype plugin indent on
        set tabstop=2
        set shiftwidth=2
        set expandtab
        set smartindent
        set autochdir                       "auto-change directory to current file
        set magic
        set mat=2
        set nocompatible                    "set nofoldenable
        set noeb " disable error bells
        set nohlsearch
        set backspace=indent,eol,start
        colorscheme elflord
        syntax on
        set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ vim-nix ];
      };
    };
    viAlias = true;
    vimAlias = true;
  };

  programs = {
    fish.enable = true;
    _1password = {
      enable = true;
    };
  };
}
