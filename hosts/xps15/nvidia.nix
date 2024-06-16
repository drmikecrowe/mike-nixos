{
  pkgs,
  lib,
  ...
}: {
  # services.xserver.videoDrivers = ["nvidia"];
  # hardware.nvidia.package = pkgs.linuxPackages.nvidia_x11_legacy390; #config.boot.kernelPackages.nvidiaPackages.legacy390;

  boot = {
    # extraModulePackages = lib.mkDefault [pkgs.linuxPackages.nvidia_x11_legacy390];
    kernelPackages = lib.mkForce pkgs.linuxPackages_5_4;
  };

  nixpkgs.config = {
    allowBroken = true;
    nvidia.acceptLicense = true;
  };
}
