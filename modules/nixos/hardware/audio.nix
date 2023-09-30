{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf (pkgs.stdenv.isLinux && config.gui.enable) {
    # Enable PipeWire
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };
    hardware.pulseaudio.enable = false;

    # Provides audio source with background noise filtered
    programs.noisetorch.enable = true;

    # These aren't necessary, but helpful for the user
    environment.systemPackages = with pkgs; [
      pamixer # Audio control
    ];

    environment.etc = {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
          ["bluez5.enable-sbc-xq"] = true,
          ["bluez5.enable-msbc"] = true,
          ["bluez5.enable-hw-volume"] = true,
          ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '';
    };
  };
}
