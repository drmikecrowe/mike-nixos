{ pkgs, ... }:

let
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";
in
{
  imports = [
    "${impermanence}/nixos.nix"
    ./hardware-configuration.nix
    ./9650.nix
    #./nvidia.nix
    ./zfs.nix
    ./persist.nix
    ../users/root.nix
    ../users/mcrowe.nix
    ../shared/managers/gnome.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    direnv
    gcc
    mc
    vim
    nmap
    parted
    bat
    grc
    pkgs.fishPlugins.plugin-git
    pkgs.fishPlugins.grc
    pkgs.fishPlugins.colored-man-pages
    home-manager
    gtk3
    gtk4
    gnome.gnome-themes-extra
    yaru-theme
  ];

  programs = {
    fish = {
      enable = true;
    };
  };

  location = {
    latitude = 34.1089;
    longitude = -77.8931;
  };

  networking = {
    hostName = "xps15";
    hostId = "c904de5f";
    search = [ "local" ];
    networkmanager = {
      enable = true;
    };
    hosts = {
      "192.168.1.107" = [ "sonarr.local" "radarr.local" "transfer.local" "sabnzbd.local" ];
    };
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint ];
    browsing = true;
  };
  # This avahi config can be necessary to connect to network print servers.
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Bluetooth
  services.blueman.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = false;

  services.flatpak.enable = true;

  # Yubikey
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
  security.pam.u2f = {
    enable = true;
    cue = true;
  };
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
    lightdm.u2fAuth = true;
  };
  security.pam.yubico = {
    enable = true;
    # debug = true;
    mode = "challenge-response";
    id = [ "19883829" ];
  };
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  systemd.services.nix-gc.unitConfig.ConditionACPower = true;

  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.system = "x86_64-linux";

  system.stateVersion = "23.05";
}
