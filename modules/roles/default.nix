{lib, ...}:
with lib; {
  imports = [
    ./desktop
    ./laptop
    ./minimal
    ./vm
  ];

  options = {
    host.role = mkOption {
      type = types.enum [
        "desktop" # Typical Workstation
        "hybrid" # A mixture of a laptop or desktop - Special purpose
        "laptop" # Workstation with differnet power profiles
        "minimal" # Bare bones
        "vm" # Some sort of virtual machine, that may have a combo of desktop or laptop
      ];
    };
  };
}
