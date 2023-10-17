{ pkgs, ... }: {
  imports = [
    ./gnupg.nix
  ];
  services.pass-secret-service = {
    package = pkgs.libsecret;
    enable = true;
  };
}
