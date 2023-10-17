{ config
, pkgs
, lib
, ...
}: {
  config = lib.mkIf pkgs.stdenv.isLinux {
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
    security.polkit.debug = true;
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
          polkit.log("action=" + action);
          polkit.log("subject=" + subject);
      });

      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("users")
            && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions"
            )
          )
        {
          return polkit.Result.YES;
        }
      })
    '';
  };
}
