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
      evolution
      firefox
      flameshot
      gimp
      glxinfo
      gtk3
      gtk4
      imagemagick
      libreoffice
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
