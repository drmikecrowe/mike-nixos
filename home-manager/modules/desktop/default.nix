{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.feature.gui;
in
  with lib; {
    imports = [
      ./apps
      ./desktopEnvironment
      ./displayServer
    ];

    options = {
      host.home.feature.gui = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enable Graphical User Interface";
        };

        displayServer = mkOption {
          type = types.enum ["x" "wayland" null];
          default = null;
          description = "Type of displayServer";
        };

        desktopEnvironment = mkOption {
          type = types.enum ["gnome"];
          default = null;
          description = "Type of desktopEnvironment";
        };
      };
    };

    config = mkIf cfg.enable {
      home = {
        packages = with pkgs; [
          polkit # Allows unprivileged processes to speak to privileged processes
          polkit_gnome # Used to bring up authentication dialogs
          xdg-utils # Desktop integration
        ];
      };

      services = {
        gnome-keyring = {
          enable = true;
          components = [
            "pkcs11"
            "secrets"
            "ssh"
          ];
        };
      };
    };
  }
