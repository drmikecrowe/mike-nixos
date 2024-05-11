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
        script_sound-tool
        pamixer # Audio control
        libcamera
      ];
    };

    # sound = lib.mkMerge [
    #   (lib.mkIf (cfg.enable && cfg.server == "pulseaudio") {
    #     enable = true;
    #   })
    #
    #   (lib.mkIf (cfg.enable && cfg.server == "pipewire") {
    #     enable = false;
    #   })
    #
    #   (lib.mkIf (! cfg.enable) {
    #     enable = false;
    #   })
    # ];

    hardware.pulseaudio = lib.mkIf (cfg.enable && cfg.server == "pulseaudio") {
      enable = true;
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
