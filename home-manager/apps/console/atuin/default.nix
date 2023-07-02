{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
  };
}
