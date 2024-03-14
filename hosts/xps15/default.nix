{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModule
    ./disks.nix
    ./hardware-configuration.nix
    ../common
  ];

  nixpkgs.config.allowUnfree = true;

  host = {
    feature = {
      graphics = {
        enable = true;
        backend = "x";
        desktopManager = "gnome";
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
      cpu = "intel";
      gpu = "intel";
      # gpu = "hybrid-nvidia"; gpu = "nvidia";
      sound = {
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
    };
    role = "laptop";
    user = {
      mcrowe.enable = true;
      root.enable = true;
    };
  };
  passthru = {
  };
}
