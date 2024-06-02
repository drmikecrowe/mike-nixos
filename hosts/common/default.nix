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
    systemPackages = with pkgs; [
      alejandra
      black
      cryptsetup
      curl
      deno
      docker-compose-language-service
      dockerfile-language-server-nodejs
      file
      firefox
      git
      git-crypt
      grc
      htop
      killall
      lazygit
      libnfs
      lm_sensors
      lua-language-server # lua lsp
      luajitPackages.luacheck
      neovim
      nfs-utils
      nixd
      nodePackages_latest.bash-language-server
      nodePackages_latest.prettier
      nodePackages_latest.pyright # Python language server
      nodePackages_latest.svelte-language-server
      nodePackages_latest.typescript-language-server
      nodePackages_latest.vscode-json-languageserver
      nvd
      parted
      pciutils
      pinentry-curses
      poetry
      prettyping
      ripgrep
      shellcheck
      shfmt
      stylua
      tailwindcss-language-server
      terraform-lsp
      unzip
      usbutils
      wget
      yaml-language-server
      zip
    ];
  };

  systemd = {
    extraConfig = "DefaultLimitNOFILE=4096:524288"; # defaults to 1024 if unset
  };

  host = {
    application = {
      _1password.enable = mkDefault true;
      appimage-run.enable = mkDefault true;
      duplicati.enable = mkDefault true;
      python311Full.enable = mkDefault true;
      vivaldi.enable = mkDefault true;
    };
    feature = {
      home-manager.enable = mkDefault true;
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

  hardware.enableRedistributableFirmware = mkDefault true;

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
    sudo.wheelNeedsPassword = mkDefault false;
  };

  services = {
    fstrim.enable = mkDefault true;
  };

  users.mutableUsers = mkDefault false;
}
