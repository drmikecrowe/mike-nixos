{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  # https://discourse.nixos.org/t/nvidia-settings-and-nvidia-offload-not-found/37187/25?invite-link=https%3A%2F%2Fdiscourse.nixos.org%2Ft%2Fnvidia-settings-and-nvidia-offload-not-found%2F37187%2F25%3Fu%3Ddrmikecrowe

  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-15-9560-nvidia
  ];

  nixpkgs = {
    config = {
      allowBroken = true;
      nvidia.acceptLicense = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      linuxKernel.packages.linux_6_1.nvidia_x11_legacy390
    ];
  };

  boot.kernelPackages = pkgs.linuxPackages.extend (self: super: {
    nvidia_x11 = super.nvidia_x11_legacy390;
  });

  services.xserver = {
    videoDrivers = [
      "nvidiaLegacy390"
    ];
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
      prime = {
        sync.enable = true;
        offload.enable = false;
      };
    };
  };

  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = ["on-the-go"];
      services.xserver = {
        videoDrivers = [
          "intel"
          "modesetting"
        ];
      };
    };
  };
}
