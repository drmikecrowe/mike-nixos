{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.appimage-run;
in
  with lib; {
    options = {
      host.application.appimage-run = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables appimage-run";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [appimage-run];
      boot.binfmt.registrations.appimage = {
        wrapInterpreterInShell = false;
        interpreter = "${pkgs.appimage-run}/bin/appimage-run";
        recognitionType = "magic";
        offset = 0;
        mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
        magicOrExtension = ''\x7fELF....AI\x02'';
      };
    };
  }
