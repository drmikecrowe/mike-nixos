{
  inputs,
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
    overlays = [
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
      "modesetting"
      "nvidiaLegacy390"
    ];
    dpi = 180;
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = true;
      nvidiaSettings = true;
      package = inputs.config.boot.kernelPackages.nvidiaPackages.legacy_390;

      # bumblebee
      prime = {
        sync.enable = false;
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };

      # full prime
      # prime = {
      #   sync.enable = true;
      #   offload = {
      #     enable = false;
      #     enableOffloadCmd = false;
      #   };
      # };
    };
    bumblebee.enable = true;
  };

  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = ["on-the-go"];
      hardware.nvidia = {
        prime = {
          offload = {
            enable = lib.mkForce true;
            enableOffloadCmd = lib.mkForce true;
          };
          sync = {
            enable = lib.mkForce false;
          };
        };
      };
    };
  };
}
