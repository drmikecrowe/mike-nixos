{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf (pkgs.stdenv.isLinux && config.gui.enable) {
    sound.enable = true;

    # Enable PipeWire
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    hardware.pulseaudio.enable = false;

    # Provides audio source with background noise filtered
    programs.noisetorch.enable = true;

    # These aren't necessary, but helpful for the user
    environment.systemPackages = with pkgs; [
      pamixer # Audio control
    ];
  };
}
