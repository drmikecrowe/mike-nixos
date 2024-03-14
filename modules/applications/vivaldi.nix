{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.vivaldi;
in
  with lib; {
    options = {
      host.application.vivaldi = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables vivaldi";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        vivaldi
        vivaldi-ffmpeg-codecs
      ];

      nixpkgs.config = {
        vivaldi = {
          proprietaryCodecs = true;
        };
      };
    };
  }
