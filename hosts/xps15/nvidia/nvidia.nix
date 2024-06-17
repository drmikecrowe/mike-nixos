{
  inputs,
  pkgs,
  lib,
  ...
}: let
in {
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-15-9560-nvidia
  ];

  nixpkgs.overlays = [
    (final: prev: {
      bumblebee = prev.bumblebee.override {
        nvidia_x11 = pkgs.linuxKernel.packages.linux_6_1.nvidia_x11_legacy390;
        extraNvidiaDeviceOptions = "BusID \"PCI:1:0:0\"";
      };
    })

    (final: prev: let
      xmodules = pkgs.lib.concatStringsSep "," (
        map (x: "${x.out or x}/lib/xorg/modules") [
          pkgs.xorg.xorgserver
          pkgs.xorg.xf86inputmouse
        ]
      );
    in {
      bumblebee = prev.bumblebee.overrideAttrs (old: {
        nativeBuildInputs =
          old.nativeBuildInputs
          ++ [
            pkgs.xorg.xf86inputmouse
          ];
        CFLAGS = [
          "-DX_MODULE_APPENDS=\\\"${xmodules}\\\""
        ];
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_1.nvidia_x11_legacy390
  ];

  boot.kernelPackages = pkgs.linuxPackages.extend (self: super: {
    nvidia_x11 = super.nvidia_x11_legacy390;
  });

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidiaLegacy390"
  ];

  hardware.nvidia = {
    # prime.sync.enable = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = inputs.config.boot.kernelPackages.nvidiaPackages.legacy_390;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };
  hardware.bumblebee.enable = true;

  hardware.opengl = {
    # extraPackages = with pkgs; [
    #   intel-media-driver
    #   (vaapiIntel.override {enableHybridCodec = true;})
    #   vaapiVdpau
    #   libvdpau-va-gl
    # ];
  };

  nixpkgs.config = {
    allowBroken = true;
    nvidia.acceptLicense = true;
  };
}
