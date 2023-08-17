{ config, pkgs, lib, ... }: {

  options = {
    vivaldi = {
      enable = lib.mkEnableOption {
        description = "Enable vivaldi.";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gui.enable && config.vivaldi.enable) {

    environment.etc = {
      "1password/custom_allowed_browsers".text = "vivaldi-bin";
    };

    # environment.systemPackages = with pkgs;
    #   [
    #     vivaldi
    #     vivaldi-ffmpeg-codecs
    #   ];

    nixpkgs.config = {
      vivaldi = {
        proprietaryCodecs = true;
      };
    };

    home-manager.users.${config.user} = {
      home = {
        packages = with pkgs; [
          vivaldi
          vivaldi-ffmpeg-codecs
        ];
      };
      xdg.mimeApps.defaultApplications = lib.mkIf pkgs.stdenv.isLinux {
        "x-scheme-handler/http" = [ "vivaldi-stable.desktop" ];
        "x-scheme-handler/https" = [ "vivaldi-stable.desktop" ];
        "x-scheme-handler/about" = [ "vivaldi-stable.desktop" ];
        "x-scheme-handler/unknown" = [ "vivaldi-stable.desktop" ];
      };
    };
  };

}

