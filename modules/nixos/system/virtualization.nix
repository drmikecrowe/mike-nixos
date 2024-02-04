{
  config,
  pkgs,
  lib,
  user,
  ...
}: {
  config = {
    virtualisation = {
      docker = {
        enable = true;
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
        storageDriver = "btrfs";
      };

      libvirtd.enable = true;
    };

    environment.systemPackages = with pkgs; [
      virt-manager
      docker-compose
    ];

    users.users.${user}.extraGroups = [
      "docker"
      "libvirtd"
    ];
    users.extraGroups.vboxusers.members = ["user-with-access-to-virtualbox"];
  };
}
