{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.programs.mcrowe.bash;
in
{
  options.programs.mcrowe.bash = {
    enable = mkEnableOption "Enables bash";
  };

  config = mkIf cfg.enable {
    users.users.mcrowe.shell = pkgs.shadow;

    programs.bash = {
      enableCompletion = true;
      keychain.enableBashIntegration = true;
      enableLsColors = true;
    };

    home.packages = with pkgs; [ exa neofetch starship ];
  };
}
