{
  config,
  pkgs,
  specialArgs,
  ...
}: let
  inherit (specialArgs) org;
  if-exists = f: builtins.pathExists f;
  existing-imports = imports: builtins.filter if-exists imports;
in {
  imports =
    [
      ./common
      ../modules
    ]
    ++ existing-imports [
      ./${org}
    ];

  home = {
    packages = with pkgs; [
    ];
  };
}
