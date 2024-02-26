{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      albert
      authy
      bcompare
      codeium
      copyq
      dbeaver
      element-desktop
      etcher
      betterbird
      firefox
      flameshot
      gcc13
      gimp
      glxinfo
      gtk3
      gtk4
      imagemagick
      libreoffice
      libsForQt5.kgpg
      meld
      peek
      qcad
      wavebox
      yubikey-manager
      yubikey-personalization-gui
      yubioath-flutter
      zoom-us
    ];
  };
}
