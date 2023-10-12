{
  sops-nix,
  lib,
  user,
  ...
}: {
  imports = [
    sops-nixsops-nix.nixosModules.default
    (lib.mkAliasOptionModule ["secrets"] ["sops" "secrets"])
  ];

  sops = {
    gnupg = {
      home = "/var/lib/sops";
      sshKeyPaths = [];
    };

    defaultSopsFile = ./secrets/encrypted/${user}.yaml;
    validateSopsFiles = false;
  };
}
