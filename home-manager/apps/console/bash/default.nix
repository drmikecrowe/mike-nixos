{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
  };

  home.packages = with pkgs; [ exa neofetch starship ];

}
