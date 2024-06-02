{
  inputs,
  outputs,
  pkgs,
  ...
}: let
  mkMountPoint = name: rec {
    device = "//nas.local/${name}";
    fsType = "cifs";
    options = [
      "iocharset=utf8"
      "noexec"
      "noatime"
      "nodev"
      "nosetuids"
      "rw"
      "user"
      "credentials=/home/mcrowe/.private/nas-credentials"
      "dir_mode=0755"
      "file_mode=0644"
    ];
  };
in {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModule
    inputs.nixos-hardware.nixosModules.dell-xps-15-9560
    {
      nixpkgs.overlays = [
        # Add overlays your own flake exports (from overlays and pkgs dir):
        outputs.overlays.additions
        outputs.overlays.modifications
        # Add overlays exported from other flakes:
      ];
    }
    # inputs.nixos-hardware.nixosModules.dell-xps-15-9560-nvidia
    ./disks.nix
    ./hardware-configuration.nix
    ../common
  ];

  environment = {
    systemPackages = with pkgs; [
      # sst
      onedrive
      onedrivegui
      publii
      pulumi-bin
      sysz
      cifs-utils
      libsmbios
      argc
      argc-completions
      carapace
    ];
  };

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      # Add overlays exported from other flakes:
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  host = {
    feature = {
      graphics = {
        enable = true;
        backend = "x";
        desktopManager = "kde";
      };
    };
    filesystem = {
      swap = {
        enable = false;
        type = "partition";
        partition = "disk/by-partlabel/swap";
      };
    };
    hardware = {
      sound = {
        enable = true;
        # server = "pipewire";
        server = "pulseaudio";
      };
      yubikey = {
        ids = [
          "19883829"
          "25079218"
        ];
      };
    };
    network = {
      hostname = "xps15";
      hostId = "c904de5f";
      mask_ad_hosts.enable = true;
    };
    role = "hybrid";
    user = {
      mcrowe.enable = true;
      root.enable = true;
    };
  };
  passthru = {
  };

  services = {
    rpcbind.enable = true; # needed for NFS

    # resolved = {
    #   enable = true;
    #   extraConfig = ''
    #     MulticastDNS=yes
    #     DNSStubListenerExtra=172.17.0.1
    #   '';
    #   dnssec = "true";
    #   fallbackDns = ["1.1.1.1" "8.8.8.8"];
    #   dnsovertls = "true";
    # };
  };

  # systemd = {
  #   mounts = [
  #     {
  #       type = "nfs";
  #       mountConfig = {
  #         Options = "rw,noatime,defaults";
  #       };
  #       what = "nas.local:/export/books";
  #       where = "/mnt/books";
  #     }
  #   ];
  # };

  # security.wrappers = {
  #   "mount.cifs" = {
  #     source = "${pkgs.cifs-utils}/bin/mount.cifs";
  #     owner = "root";
  #     group = "root";
  #     setuid = true;
  #   };
  # };

  fileSystems = {
    "/mnt/books" = mkMountPoint "books";
    "/mnt/backups" = mkMountPoint "backups";
    "/mnt/pictures" = mkMountPoint "pictures";
    "/mnt/music" = mkMountPoint "music";
    "/mnt/videos" = mkMountPoint "videos";
  };
}
