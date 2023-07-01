{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.programs.mcrowe.nushell;
in
{
  options.programs.mcrowe.nushell = {
    enable = mkEnableOption "Enables nushell";
  };

  config = mkIf cfg.enable {
    users.users.mcrowe.shell = pkgs.shadow;

    programs.nushell = {
      enableCompletion = true;
      keychain.enableNushellIntegration = true;
      enableLsColors = true;
    };

    home-manager.users.mcrowe.home.packages = with pkgs; [ exa neofetch ];
  };
}
