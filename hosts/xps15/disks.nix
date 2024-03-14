# https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/
let
  rawdisk1 = "/dev/nvme0n1";
in {
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = ["defaults" "size=2G" "mode=755"];
  };

  fileSystems."/tmp" = {
    device = "none";
    fsType = "tmpfs";
    options = ["noatime" "nodev" "size=8G"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D51A-06E6";
    fsType = "vfat";
    neededForBoot = true;
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/2cceef78-3990-4cfd-b865-00287a5734de";
    fsType = "ext4";
  };

  fileSystems."/keep" = {
    device = "/dev/disk/by-uuid/e0d4025b-a3be-424d-9df8-47da71e7a94c";
    fsType = "ext4";
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/bbb542df-748e-4fb9-b2c7-668a3d1f4414";
    fsType = "ext4";
  };

  fileSystems."/usr" = {
    device = "/dev/disk/by-uuid/4a853a98-2218-456a-a303-88d51dcb464c";
    fsType = "ext4";
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/9c82030d-a629-40b4-893f-85cc0e5b52e3";
    fsType = "ext4";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/0b2a4db9-89c3-43aa-a1d3-22a5c4e02442";}
  ];

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
        parentDirectory = {mode = "u=rwx,g=rx,o=rx";};
      }
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };

  disko = {
    enableConfig = false;
    devices = {
      disk = {
        ${rawdisk1} = {
          device = "${rawdisk1}";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "500M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              primary = {
                size = "100%";
                content = {
                  type = "lvm_pv";
                  vg = "pool";
                };
              };
            };
          };
        };
      };
      lvm_vg = {
        pool = {
          type = "lvm_vg";
          lvs = {
            aaa = {
              size = "1M";
            };
            zzz = {
              size = "1M";
            };
            usr = {
              size = "10G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/usr";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            var = {
              size = "10G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            keep = {
              size = "20G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/keep";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            swap = {
              size = "32G";
              content = {
                type = "swap";
                resumeDevice = false;
              };
            };
            nix = {
              size = "100G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            home = {
              size = "100%FREE";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home";
              };
            };
          };
        };
      };
    };
  };
}
