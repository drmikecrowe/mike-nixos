{ config, lib, pkgs, ... }:

{
  environment.persistence."/keep" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/etc/cups"
    ];
    files = [
      "/etc/machine-id"
      {
        file = "/etc/nix/id_rsa";
        parentDirectory = { mode = "u=rwx,g=rx,o=rx"; };
      }
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };
}
