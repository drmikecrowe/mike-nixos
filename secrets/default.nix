{
  config,
  sops-nix,
  lib,
  user,
  ...
}: {
  imports = [<sops-nix/modules/sops>];
}
