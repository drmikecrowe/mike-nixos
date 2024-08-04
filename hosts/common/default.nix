{
  config,
  outputs,
  lib,
  pkgs,
  ...
}: {
  imports =
    [
      ./locale.nix
      ./nix.nix
      ../../users
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  boot = {
    initrd = {
      compressor = lib.mkDefault "zstd";
      compressorArgs = lib.mkDefault ["-19"];

      systemd = {
        strip = lib.mkDefault true; # Saves considerable space in initrd
      };
    };
    kernel.sysctl = {
      "vm.dirty_ratio" = lib.mkDefault 6; # sync disk when buffer reach 6% of memory
    };
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest; # Latest kernel
  };

  environment = {
    defaultPackages = []; # Don't install any default programs, force everything
    enableAllTerminfo = lib.mkDefault false;
    localBinInPath = true;
    systemPackages = with pkgs; [
      chezmoi
      cryptsetup
      file
      git-crypt
      grc
      htop
      killall
      lazygit
      libnfs
      lm_sensors
      nfs-utils
      nurl
      nvd
      parted
      pciutils
      pinentry-curses
      prettyping
      ripgrep
      unzip
      usbutils
      wget
      zip
    ];
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
  };

  systemd = {
    extraConfig = "DefaultLimitNOFILE=4096:524288"; # defaults to 1024 if unset
  };

  host = {
    application = {
      _1password.enable = lib.mkDefault true;
      appimage-run.enable = lib.mkDefault true;
      duplicati.enable = lib.mkDefault true;
      python3Full.enable = lib.mkDefault true;
      vivaldi.enable = lib.mkDefault true;
      xonsh.enable = lib.mkDefault true;
    };
    feature = {
      home-manager.enable = lib.mkDefault true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;

    configPackages = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  hardware.enableRedistributableFirmware = lib.mkDefault true;

  security = {
    pam.loginLimits = [
      # Increase open file limit for sudoers
      {
        domain = "*";
        item = "nofile";
        type = "soft";
        value = "4096";
      }
      {
        domain = "*";
        item = "nofile";
        type = "hard";
        value = "524288";
      }
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
    sudo.wheelNeedsPassword = lib.mkDefault false;
  };

  services = {
    fstrim.enable = lib.mkDefault true;
  };

  users.mutableUsers = lib.mkDefault false;
}
