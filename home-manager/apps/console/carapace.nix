{ pkgs, ... }:

{
  home.packages = with pkgs; [
    carapace
  ];
  programs.bash.bashrcExtra = ''
    source <(carapace _carapace)
  '';
  programs.nushell.extraConfig = ''
    carapace _carapace
  '';
}
