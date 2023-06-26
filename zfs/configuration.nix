{ my-config, zfs-root, inputs, pkgs, lib, ... }: {
  # load module config to top-level configuration
  inherit my-config zfs-root;

  # Let 'nixos-version --json' know about the Git revision
  # of this flake.
  system.configurationRevision = if (inputs.self ? rev) then
    inputs.self.rev
  else
    throw "refuse to build: git tree is dirty";

  system.stateVersion = "22.11";

  # Enable NetworkManager for wireless networking,
  # You can configure networking with "nmtui" command.
  networking.useDHCP = true;
  networking.networkmanager.enable = false;

  users.users = {
    root = {
      initialHashedPassword = "$6$ueOkekfaxwdILTmn$QS6vJVikTaqJauI0zezC3RrIuRZQ8pyV1FC0MignJDz8l6wfSdwLmtt5CNoSEBAOohqTadSf/URFrKlCTuzAb/";
      openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1KoDe7aKQU8yUMOuRPOIA7Mqu5vbUSBe9sVs7yyFkuXuHAEEBTABfBYo7ZzwqPUXeltW5uNjJmeZBPBZChxzcZLF4J1vd5BYqFjHBcSLSZzvWZ4BNN1ZBy2ACKOgInHWwoHA7ruJ/A0WvHdiNBiYwg5xMaYE8sYZUA22jvS+gXo46fRo7HfMTBlVap0G3xfNbMEiez1+1W56tnOIsOzcmJ17+YuJtZCDNd4A8Oz6heYjiDwtIDosUi5yU3SAqxi1unYiaYdwSI5vigz6f9dqg7/CVO3cIiJwlt2d2vjXF+k8XfgrjGKJibAhNv4bE1pdP1IDCTXTliA63qRATKSj1" ];
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/scan/not-detected.nix"
    # "${inputs.nixpkgs}/nixos/modules/profiles/qemu-guest.nix"
  ];

  services.openssh = {
    enable = lib.mkDefault true;
    settings = { PasswordAuthentication = lib.mkDefault false; };
    hostKeys = [
      {
        path = "/persist/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/persist/ssh/ssh_host_rsa_key";
        type = "rsa";
        bits = 4096;
      }
    ];
  };

  boot.zfs.forceImportRoot = lib.mkDefault false;

  nix.settings.experimental-features = lib.mkDefault [ "nix-command" "flakes" ];

  programs.git.enable = true;

  security = {
    doas.enable = lib.mkDefault true;
    sudo.enable = lib.mkDefault false;
  };

  environment = {
    variables = {
      EDITOR = "vim";
    };
    systemPackages = with pkgs; [
      git
      file
      gnupg
      xclip
      ripgrep
      direnv
      jq
      mc 
      tmux 
      neovim
    ];

    # Wacky erase-root-on-every-boot stuff.
    etc."NetworkManager/system-connections".source = "/rpool/persist/etc/NetworkManager/system-connections/";
  };

  systemd.tmpfiles.rules = [
    "L /var/lib/bluetooth - - - - /persist/var/lib/bluetooth"
  ];
  
}
