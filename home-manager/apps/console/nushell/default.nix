{ pkgs, ... }:

{
  programs.nushell = {
    enableCompletion = true;
    keychain.enableNushellIntegration = true;
  };

  home.packages = with pkgs; [ exa neofetch starship ];
}
