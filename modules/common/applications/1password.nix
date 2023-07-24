{ config, pkgs, lib, ... }: {

  options = {
    _1password = {
      enable = lib.mkEnableOption {
        description = "Enable 1Password.";
        default = false;
      };
    };
  };

  config = lib.mkIf config._1password.enable {
    programs = {
      dconf.enable = true;
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "mcrowe" ];
      };
    };
    environment.systemPackages = with pkgs; [
      vivaldi
      vivaldi-ffmpeg-codecs
    ];
  };

}
