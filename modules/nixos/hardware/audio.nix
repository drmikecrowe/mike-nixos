{ config, pkgs, lib, ... }:

let

  # These micro-scripts change the volume while also triggering the volume
  # notification widget

  increaseVolume = pkgs.writeShellScriptBin "increaseVolume" ''
    ${pkgs.pamixer}/bin/pamixer -i 2
    volume=$(${pkgs.pamixer}/bin/pamixer --get-volume)
    ${pkgs.volnoti}/bin/volnoti-show $volume
  '';

  decreaseVolume = pkgs.writeShellScriptBin "decreaseVolume" ''
    ${pkgs.pamixer}/bin/pamixer -d 2
    volume=$(${pkgs.pamixer}/bin/pamixer --get-volume)
    ${pkgs.volnoti}/bin/volnoti-show $volume
  '';

  toggleMute = pkgs.writeShellScriptBin "toggleMute" ''
    ${pkgs.pamixer}/bin/pamixer --toggle-mute
    mute=$(${pkgs.pamixer}/bin/pamixer --get-mute)
    if [ "$mute" == "true" ]; then
        ${pkgs.volnoti}/bin/volnoti-show --mute
    else
        volume=$(${pkgs.pamixer}/bin/pamixer --get-volume)
        ${pkgs.volnoti}/bin/volnoti-show $volume
    fi
  '';

in
{

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
      volnoti # Volume notifications
    ];

    home-manager.users.${config.user} = {

      # Graphical volume notifications
      services.volnoti.enable = true;

    };
  };

}
