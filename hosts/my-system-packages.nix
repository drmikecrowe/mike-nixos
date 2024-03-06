{pkgs, ...}: {
  config = {
    environment.systemPackages = with pkgs; [
      appimage-run
      black # Python formatter
      cryptsetup
      curl
      file
      git
      grc
      htop
      killall
      lm_sensors
      home-manager
      nodejs_18
      parted
      pciutils
      pinentry-curses
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
      vlc
      wget
      xdg-utils
      zip
    ];
  };
}
