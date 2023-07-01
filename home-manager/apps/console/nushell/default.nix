{
  programs.nushell = {
    enableCompletion = true;
    keychain.enableNushellIntegration = true;
    enableLsColors = true;
  };

  packages = with pkgs; [ exa neofetch starship ];
}
