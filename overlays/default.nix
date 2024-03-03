final: prev: {
  services.thermald.package = prev.thermald.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ../patches/thermald-422.patch ];
  });
  openssh = prev.openssh.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ../patches/openssh.patch ];
    doCheck = false;
  });
}
