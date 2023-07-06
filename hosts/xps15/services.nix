{ config, pkgs, ... }:

{
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
}
