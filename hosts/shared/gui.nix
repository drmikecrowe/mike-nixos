{ pkgs, ... }:
{
  programs = {
    dconf.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "mcrowe" ];
    };
  };
}
