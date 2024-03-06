{
  config,
  lib,
  inputs,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-15-9560-nvidia
  ];

  boot = {
    blacklistedKernelModules = ["nouveau"];
    kernelParams = ["acpi_rev_override=1"];
  };

  hardware = {
    nvidia = {
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
    };
  };

  services.xserver.videoDrivers = [
    "nvidiaLegacy390"
  ];
  # hardware.bumblebee.enable = true;
  # hardware.bumblebee.driver = "nvidia";
  # hardware.bumblebee.pmMethod = "bbswitch";
  # nixpkgs.overlays = [
  #   (self: super: {
  #     bumblebee =
  #       super.bumblebee.overrideAttrs
  #       (oldAttrs: {meta = oldAttrs.meta // {broken = false;};});

  #     # Adjust the NVIDIA driver package
  #     nvidiaPackages =
  #       super.nvidiaPackages
  #       // {
  #         legacy390 = super.nvidia_x11_legacy390;
  #       };
  #   })
  # ];
}
