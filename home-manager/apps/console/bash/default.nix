{
  programs.bash = {
    enableCompletion = true;
    keychain.enableBashIntegration = true;
    enableLsColors = true;
  };

  packages = with pkgs; [ exa neofetch starship ];

}
