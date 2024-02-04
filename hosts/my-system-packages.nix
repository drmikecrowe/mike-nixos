{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      albert
      appimage-run
      authy
      bcompare
      black # Python formatter
      chatgpt-cli
      copyq
      curl
      dbeaver
      element-desktop
      file
      firefox
      fish
      flameshot
      gimp
      git
      gtk3
      gtk4
      htop
      killall
      lm_sensors
      meld
      nodePackages.pyright # Python language server
      nodejs_18
      nushell
      parted
      pciutils
      peek
      pinentry-qt
      poetry
      python311Full
      python311Packages.flake8 # Python linter
      python311Packages.mypy # Python linter
      python311Packages.pip
      python311Packages.poetry-core
      python311Packages.pynvim
      sysz
      unzip
      usbutils
      vim
      vlc
      wget
      xdg-utils
      yubikey-manager
      yubikey-personalization-gui
      yubioath-flutter
      zip
      zoom-us
    ];
  };

}
