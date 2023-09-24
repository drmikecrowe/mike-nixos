{
  config,
  pkgs,
  lib,
  ...
}: let
  nide = builtins.fetchTarball "https://github.com/jluttine/NiDE/archive/master.tar.gz";
in {
  imports = [
    "${nide}/nix/configuration.nix"
  ];

  options = {
    nide = {
      enable = lib.mkEnableOption {
        description = "Enable nide.";
        default = false;
      };
    };
  };

  config = lib.mkIf config.nide.enable {
    services.xserver.desktopManager.nide = {
      enable = true;
      installPackages = true;
    };
    nix.extraOptions = ''
      tarball-ttl = 0
    '';
  };
}
