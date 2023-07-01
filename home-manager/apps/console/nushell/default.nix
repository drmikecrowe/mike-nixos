{ pkgs, ... }:

{
  programs.nushell = {
    enableCompletion = true;
    keychain.enableNushellIntegration = true;
    enableLsColors = true;
  };

  home.packages = with pkgs; [ exa neofetch starship ];
}
