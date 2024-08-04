{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.hardware.yubikey;
  # specificPkgs =
  #   import (builtins.fetchTarball {
  #     # URL to the tarball of the specific nixpkgs commit
  #     # Choose the right version for pcsclite using https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable&package=pcsclite
  #     url = "https://github.com/NixOS/nixpkgs/archive/e89cf1c932006531f454de7d652163a9a5c86668.tar.gz";
  #     sha256 = "sha256:09cbqscrvsd6p0q8rswwxy7pz1p1qbcc8cdkr6p6q8sx0la9r12c";
  #   }) {
  #     inherit (config.nixpkgs.hostPlatform) system;
  #   };
  #
  # # Use pcsclite from the specific nixpkgs version
  # pcsclite = specificPkgs.pcsclite;
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
      environment.systemPackages = [
        #yubikey-manager
        #yubikey-manager-qt
        # pkgs.pcsclite
        pkgs.yubikey-personalization
        pkgs.yubikey-personalization-gui
        pkgs.yubico-piv-tool
        pkgs.yubioath-flutter
      ];

      hardware.gpgSmartcards.enable = true;

      services = {
        pcscd.enable = true;
        udev.packages = [pkgs.yubikey-personalization];
      };
      security.pam.u2f = {
        enable = true;
        settings = {
          cue = true;
        };
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
