{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  imports = [
    ./intel.nix
  ];

  options = {
    host.hardware = {
      cpu = mkOption {
        type = types.enum ["intel" "vm-intel" null];
        default = null;
        description = "Type of CPU: intel, vm-intel";
      };
    };
  };
}
