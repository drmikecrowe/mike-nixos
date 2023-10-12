_: {
  imports = [
    ./gnupg.nix
  ];
  services.pass-secret-service = {
    enable = true;
    package = pkgs.libsecret;
  };
}
