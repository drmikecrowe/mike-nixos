{ config, desktop, lib, pkgs, ...}:
let
  ifExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
   # Only include desktop components if one is supplied.
  imports = [
    ./packages-console.nix
  ] ++ lib.optional (builtins.isString desktop) ./packages-desktop.nix;

  users.users.mcrowe = {
    description = "Mike Crowe";
    extraGroups = [
        "audio"
        "networkmanager"
        "users"
        "video"
        "wheel"
      ]
      ++ ifExists [
        "docker"
      ];
    # mkpasswd -m sha-512
    hashedPassword = "$6$Y7qx9p8syq.40e7A$ga4Zxm6pihu2mS3XSmlWzfyJx8Aw77VrNaMPazw.GolPL5eqddZ9IBFyMDw/v957yAUAzbuKT6RHjKJrwQTyX1";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1KoDe7aKQU8yUMOuRPOIA7Mqu5vbUSBe9sVs7yyFkuXuHAEEBTABfBYo7ZzwqPUXeltW5uNjJmeZBPBZChxzcZLF4J1vd5BYqFjHBcSLSZzvWZ4BNN1ZBy2ACKOgInHWwoHA7ruJ/A0WvHdiNBiYwg5xMaYE8sYZUA22jvS+gXo46fRo7HfMTBlVap0G3xfNbMEiez1+1W56tnOIsOzcmJ17+YuJtZCDNd4A8Oz6heYjiDwtIDosUi5yU3SAqxi1unYiaYdwSI5vigz6f9dqg7/CVO3cIiJwlt2d2vjXF+k8XfgrjGKJibAhNv4bE1pdP1IDCTXTliA63qRATKSj1
    ];
    packages = [ pkgs.home-manager ];
    shell = pkgs.fish;
  };
}
