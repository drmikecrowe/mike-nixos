{
  config,
  inputs,
  outputs,
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

  nixpkgs = {
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
    role = "hybrid";
    user = {
      mcrowe.enable = true;
      root.enable = true;
    };
  };
  passthru = {
  };
}
