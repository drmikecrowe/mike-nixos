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
    flags = [
      "--disable-up-arrow"
    ];
  };
}
