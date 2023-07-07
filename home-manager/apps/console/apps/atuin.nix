{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      atuin
    ];
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    flags = [
      "--disable-up-arrow"
    ];
  };
}
