{
  inputs,
  lib,
  user,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.default
  ];
  sops = {
    defaultSopsFile = ./encrypted.yaml;
    # validateSopsFiles = false;
    gnupg.home = "/home/${user}/.gnupg";
    gnupg.sshKeyPaths = [];
    age.sshKeyPaths = [];
    # secrets."root" = {};
    # secrets."mcrowe" = {};
    # secrets."location" = {};
    # secrets."git" = {};
    # secrets."ssh" = {};
  };
}
