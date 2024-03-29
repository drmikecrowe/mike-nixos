{
  config,
  outputs,
  lib,
  pkgs,
  ...
}:
with lib; {
  imports =
    [
      ./locale.nix
      ./nix.nix
      ../../users
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  boot = {
    initrd = {
      compressor = mkDefault "zstd";
      compressorArgs = mkDefault ["-19"];

      systemd = {
        strip = mkDefault true; # Saves considerable space in initrd
      };
    };
    kernel.sysctl = {
      "vm.dirty_ratio" = mkDefault 6; # sync disk when buffer reach 6% of memory
    };
    kernelPackages = pkgs.linuxPackages_latest; # Latest kernel
  };

  environment = {
    defaultPackages = []; # Don't install any default programs, force everything
    enableAllTerminfo = mkDefault false;
    localBinInPath = true;
  };

  host = {
    application = {
      _1password.enable = mkDefault true;
      appimage-run.enable = mkDefault true;
      black.enable = mkDefault true;
      cryptsetup.enable = mkDefault true;
      curl.enable = mkDefault true;
      duplicati.enable = mkDefault true;
      file.enable = mkDefault true;
      firefox.enable = mkDefault true;
      git.enable = mkDefault true;
      grc.enable = mkDefault true;
      htop.enable = mkDefault true;
      killall.enable = mkDefault true;
      lm_sensors.enable = mkDefault true;
      nodejs_18.enable = mkDefault true;
      parted.enable = mkDefault true;
      pciutils.enable = mkDefault true;
      pinentry-curses.enable = mkDefault true;
      poetry.enable = mkDefault true;
      python311Full.enable = mkDefault true;
      sysz.enable = mkDefault true;
      usbutils.enable = mkDefault true;
      vivaldi.enable = mkDefault true;
      xonsh.enable = mkDefault true;
      wget.enable = mkDefault true;
      xdg-utils.enable = mkDefault true;
      zip.enable = mkDefault true;
    };
    feature = {
      home-manager.enable = mkDefault true;
    };
  };

  # TODO: Do I really need portals?
  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;

  #   configPackages = with pkgs; [
  #     xdg-desktop-portal-wlr
  #     xdg-desktop-portal-gtk
  #   ];
  # };

  hardware.enableRedistributableFirmware = mkDefault true;

  security = {
    pam.loginLimits = [
      # Increase open file limit for sudoers
      {
        domain = "@wheel";
        item = "nofile";
        type = "soft";
        value = "524288";
      }
      {
        domain = "@wheel";
        item = "nofile";
        type = "hard";
        value = "1048576";
      }
    ];
    sudo.wheelNeedsPassword = mkDefault false;
  };

  services.fstrim.enable = mkDefault true;
  users.mutableUsers = mkDefault false;
}
