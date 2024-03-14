{
  inputs,
  outputs,
  systems,
  stateVersion,
  ...
}: let
  helpers = import ./helpers.nix {inherit inputs outputs systems stateVersion;};
in {
  inherit (helpers) mkHome mkHost forAllSystems;
}
