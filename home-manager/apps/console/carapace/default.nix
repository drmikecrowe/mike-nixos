{ pkgs, ... }:

{
  home.packages = with pkgs; [
    carapace
  ];
  programs.bash.bashrcExtra = ''
    eval "$(carapace init bash)"
  '';
  programs.nushell.extraConfig = ''
    carapace _carapace
  '';
}
