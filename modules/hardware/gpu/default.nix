{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  imports = [
    ./intel.nix
    ./nvidia.nix
  ];

  options = {
    host.hardware.gpu = mkOption {
      type = types.enum ["intel" "nvidia" "hybrid-nvidia" "hybrid-amd" "integrated-amd" "pi" null];
      default = null;
      description = "Manufacturer/type of the primary system GPU";
    };
  };
}
