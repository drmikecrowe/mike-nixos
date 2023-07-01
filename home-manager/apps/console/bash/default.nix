{ pkgs, ... }:

{
  programs.bash = {
    enableCompletion = true;
    keychain.enableBashIntegration = true;
    enableLsColors = true;
  };

  home.packages = with pkgs; [ exa neofetch starship ];

}
