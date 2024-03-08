{
  disko,
  ...
}: {
  disko.nixosModules.disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Fanxiang_S500PRO_2TB_FXS500PRO231912172";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              label = "ESP";
              name = "ESP";
              start = "1MiB";
              end = "1024MiB";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            swap = {
              label = "swap";
              size = "25G";
              content = {
                type = "swap";
                resumeDevice = false;
              };
            };
            root = {
              label = "rootfs";
              name = "btrfs";
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/root-blank" = {
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/home" = {
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/home/active" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/home/snapshots" = {
                    mountpoint = "/home/.snapshots";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/persist" = {
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/persist/active" = {
                    mountpoint = "/persist";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/persist/snapshots" = {
                    mountpoint = "/persist/.snapshots";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/var_local" = {
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/var_local/active" = {
                    mountpoint = "/var/local";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/var_local/snapshots" = {
                    mountpoint = "/var/local/.snapshots";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/var_log" = {
                    mountpoint = "/var/log";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
