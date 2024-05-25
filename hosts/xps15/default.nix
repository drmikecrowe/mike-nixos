{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModule
    inputs.nixos-hardware.nixosModules.dell-xps-15-9560
    # inputs.nixos-hardware.nixosModules.dell-xps-15-9560-nvidia
    ./disks.nix
    ./hardware-configuration.nix
    ../common
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  environment = {
    systemPackages = with pkgs; [
      # sst
      onedrive
      onedrivegui
      publii
      pulumi-bin
      sysz
      libsmbios
    ];
  };

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
        server = "pipewire";
        # server = "pulseaudio";
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
