{ config, pkgs, ... }:

{
  users = {
    mutableUsers = false;
    users = {

      mcrowe = {
        initialHashedPassword = "\$6\$t4MAW7auU8HtLhkm\$sLOs6qFiMPKB/sFpKNTQAYWjIkjqXukABUAD/vQtaCXQw/zVAx/G3N2d35ujv0O3JiCb7c/ztpCAO0uEsiw1T0";
        extraGroups = [ "wheel" "audio" "video" "bluetooth" "networkmanager" "docker" "libvirtd" ];
        isNormalUser = true;
        uid = 1000;
        home = "/home/mcrowe";
      };
    };

  };
}
