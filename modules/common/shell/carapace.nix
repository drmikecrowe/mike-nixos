{ config, pkgs, lib, ... }: {

  options.carapace.enable = lib.mkEnableOption "carapace Shell History.";

  config.home-manager.users.${config.user} = lib.mkIf config.carapace.enable {

    home.packages = with pkgs; [ carapace ];
    programs.bash.bashrcExtra = ''
      source <(carapace _carapace)
    '';
    programs.nushell.extraConfig = ''
      carapace _carapace
    '';

  };

}
