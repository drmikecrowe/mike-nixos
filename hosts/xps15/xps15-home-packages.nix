{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      glxinfo
      qcad
      wavebox
    ];
  };
}
