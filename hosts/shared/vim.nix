{ pkgs, ... }:
{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {  }).customize{
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-airline ];
        opt = [];
      };
      vimrcConfig.customRC = ''
        " your custom vimrc
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
        colorscheme github
        syntax on
        " ...
      '';
    }
  )];
}