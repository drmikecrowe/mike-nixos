final: prev: {
  openssh = prev.openssh.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ../patches/openssh.patch ];
    doCheck = false;
  });
}
