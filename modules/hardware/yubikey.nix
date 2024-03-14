{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.hardware.yubikey;
in
  with lib; {
    options = {
      host.hardware.yubikey = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enable Yubikey support";
        };
        ids = mkOption {
          default = [];
          type = with types; array;
          description = "Authentication ID's of yubikeys allowed";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        #yubikey-manager
        #yubikey-manager-qt
        yubikey-personalization
        yubikey-personalization-gui
        yubico-piv-tool
        yubioath-flutter
      ];

      hardware.gpgSmartcards.enable = true;

      services = {
        pcscd.enable = true;
        udev.packages = [pkgs.yubikey-personalization];
      };
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
        id = cfg.ids;
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

      programs = {
        ssh.startAgent = false;
        gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
        };
      };
    };
  }
