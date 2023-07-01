{ pkgs, ... }:

{
  programs.nushell = {
    enableCompletion = true;
  };

  home.packages = with pkgs; [ exa neofetch starship ];
}
