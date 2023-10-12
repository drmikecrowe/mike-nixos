{ config
, lib
, inputs
, pkgs
, modulesPath
, ...
}:
let
  powerMode = "performance";
in
{
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-15-9560-intel
    inputs.impermanence.nixosModule
    ./boot.nix
    ./disks.nix
  ];

  powerManagement.cpuFreqGovernor = powerMode;

  # Fix unreadable tty under high dpi
  console = {
    packages = [ pkgs.terminus_font ];
    font = "ter-124n";
  };

  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];

      # Enable touchpad support (enabled default in most desktopManager).
      synaptics = {
        enable = true;
        palmDetect = true;
        twoFingerScroll = true;
        minSpeed = "1.0";
        maxSpeed = "1.12";
        accelFactor = "0.01";
      };
    };
  };

  # Network
  networking = {
    useDHCP = pkgs.lib.mkDefault true;
    hostName = "xps15";
    hostId = "c904de5f";
  };

  hardware = {
    cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport = true;
    };

    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      prime = {
        sync.enable = true;

        # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
        nvidiaBusId = "PCI:1:0:0";

        # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
        intelBusId = "PCI:0:2:0";
      };
    };
  };
}
