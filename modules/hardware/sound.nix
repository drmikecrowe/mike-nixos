{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.hardware.sound;
in {
  options = {
    host.hardware.sound = {
      enable = lib.mkOption {
        default = false;
        type = with lib.types; bool;
        description = "Enable Sound";
      };
      server = lib.mkOption {
        type = lib.types.str;
        default = "pulseaudio";
        description = "Which sound server (pulseaudio/pipewire)";
      };
    };
  };

  config = {
    environment = lib.mkIf cfg.enable {
      systemPackages = with pkgs; [
        pamixer # Audio control
        libcamera
      ];
    };

    sound = lib.mkMerge [
      (lib.mkIf (cfg.enable && cfg.server == "pulseaudio") {
        enable = true;
      })

      (lib.mkIf (cfg.enable && cfg.server == "pipewire") {
        enable = false;
      })

      (lib.mkIf (! cfg.enable) {
        enable = false;
      })
    ];

    hardware.pulseaudio = lib.mkIf (cfg.enable && cfg.server == "pulseaudio") {
      enable = true;
      tcp.enable = true; # necessary to listen to non-systemwide (only root) mpd daemon, c.f. https://askubuntu.com/a/555484

      # https://nixos.org/nixpkgs/manual/#sec-steam-play
      support32Bit = true;
      # https://nixos.wiki/wiki/Bluetooth
      # "Only ... full ... has Bluetooth support"
      package = pkgs.pulseaudioFull;
    };

    services.pipewire = lib.mkIf (cfg.enable && cfg.server == "pipewire") {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    security.rtkit = lib.mkIf (cfg.enable && cfg.server == "pipewire") {
      enable = true;
    };
  };
}
