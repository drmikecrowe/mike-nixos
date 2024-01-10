{ config, pkgs, lib, ... }: {

  config = lib.mkIf config.custom.vivaldi.enable {

    environment.etc = {
      "1password/custom_allowed_browsers".text = ''
        vivaldi-bin
        wavebox
      '';
    };

    environment.systemPackages = with pkgs;
      [
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
