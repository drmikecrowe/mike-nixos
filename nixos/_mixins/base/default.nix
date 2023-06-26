{ hostid, hostname, lib, pkgs, ...}: {
  imports = [
    ./locale.nix
    ../services/fwupd.nix
    ../services/openssh.nix
    ../services/tailscale.nix
    ../services/zerotier.nix
  ];

  environment.systemPackages = with pkgs; [
    binutils
    curl
    desktop-file-utils
    direnv
    file
    gcc
    git
    home-manager
    killall
    man-pages
    mc
    mergerfs
    mergerfs-tools
    pciutils
    rsync
    unzip
    usbutils
    vim
    wget
    xdg-utils
  ];

  # Use passed in hostid and hostname to configure basic networking
  networking = {
    hostName = hostname;
    hostId = hostid;
    useDHCP = lib.mkDefault true;
  };

  programs = {
    dconf.enable = true;
    fish.enable = true;
  };

  security.rtkit.enable = true;
}
