{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      albert
      authy
      bcompare
      betterbird
      codeium
      copyq
      dbeaver
      dconf2nix
      element-desktop
      etcher
      firefox
      flameshot
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
      teams-for-linux
      wavebox
      wezterm
      yubikey-manager
      yubikey-personalization-gui
      yubioath-flutter
      zoom-us
    ];
  };
}
