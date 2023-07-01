{ pkgs, ... }:

{
  programs.nushell = {
    enable = true;
  };

  home.packages = with pkgs; [ exa neofetch starship ];
}
