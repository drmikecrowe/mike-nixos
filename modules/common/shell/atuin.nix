{ config, pkgs, lib, ... }: {

  options.atuin.enable = lib.mkEnableOption "Atuin Shell History.";

  config.home-manager.users.${config.user} = lib.mkIf config.atuin.enable {

    home.packages = with pkgs; [ atuin ];
    programs.atuin = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
      flags = [ "--disable-up-arrow" ];
    };

  };

}
