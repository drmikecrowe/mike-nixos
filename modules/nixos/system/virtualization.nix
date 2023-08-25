{ config, pkgs, lib, ... }: {

  config = {

    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    virtualisation.libvirtd.enable = true;

    home-manager.users.mcrowe = {
      home.packages = with pkgs; [
        virt-manager
        docker-compose
      ];
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
