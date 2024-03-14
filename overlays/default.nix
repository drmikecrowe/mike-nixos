# { inputs, ... }:
# {
#   additions = final: _prev: import ../pkgs { pkgs = final; };
#   services.thermald.package = final: prev: prev.thermald.overrideAttrs (old: {
#     patches = (old.patches or []) ++ [../patches/thermald-422.patch];
#   });
#   openssh = final: prev: prev.openssh.overrideAttrs (old: {
#     patches = (old.patches or []) ++ [../patches/openssh.patch];
#     doCheck = false;
#   });
# }
final: prev: {
  additions = final: _prev: import ../pkgs {pkgs = final;};
  services.thermald.package = prev.thermald.overrideAttrs (old: {
    patches = (old.patches or []) ++ [../patches/thermald-422.patch];
  });
  openssh = prev.openssh.overrideAttrs (old: {
    patches = (old.patches or []) ++ [../patches/openssh.patch];
    doCheck = false;
  });
  argc-completions = prev.callPackage ./argc-completions.nix {};
}
