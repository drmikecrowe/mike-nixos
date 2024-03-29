{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  device = config.host.hardware;
in {
  config = mkIf (device.gpu == "intel" || device.gpu == "hybrid-nv") {
    services.xserver.videoDrivers = ["modesetting"];

    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
    };

    boot = {
      initrd.kernelModules = ["i915"];
      blacklistedKernelModules = [
        "nouveau"
      ];
    };

    hardware.opengl = {
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        libvdpau-va-gl
        vaapiIntel
        vaapiVdpau
      ];
    };

    environment.variables = mkIf (config.hardware.opengl.enable && device.gpu != "hybrid-nv") {
      VDPAU_DRIVER = "va_gl";
    };
  };
}
