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
    unfreePackages = [ "1password" "_1password-gui" ];
    programs = {
      dconf.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "mcrowe" ];
      };
    };
  };

}
