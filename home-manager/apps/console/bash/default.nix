{ pkgs, ... }:

{
  programs.bash = {
    enableCompletion = true;
    keychain.enableBashIntegration = true;
  };

  home.packages = with pkgs; [ exa neofetch starship ];

}
