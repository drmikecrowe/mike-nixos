{
  pkgs,
  lib,
  ...
}: let
  kernel = pkgs.linuxPackages_6_1.extend (self: super: {
    nvidia_x11 = super.nvidia_x11_legacy390;
  });
in {
  boot = {
    kernelPackages = lib.mkForce kernel;
    initrd = {
      compressor = lib.mkForce "gzip";
    };
  };
}
