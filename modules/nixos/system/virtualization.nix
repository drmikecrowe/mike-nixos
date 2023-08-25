{ config, pkgs, lib, ... }: {

  config = {

    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    virtualisation.libvirtd.enable = true;

    environment.systemPackages = with pkgs; [ virt-manager ];

    home-manager.users.mcrowe = {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
        };
      };
    };

    users.users.mcrowe.extraGroups = [
      "docker"
      "libvirtd"
    ];

  };

}
