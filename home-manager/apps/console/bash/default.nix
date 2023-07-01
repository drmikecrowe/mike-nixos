{ pkgs, ... }:

{
  programs.bash = {
    enableCompletion = true;
  };

  home.packages = with pkgs; [ exa neofetch starship ];

}
