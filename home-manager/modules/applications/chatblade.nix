{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.chatblade;
in
  with lib; {
    options = {
      host.home.applications.chatblade = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables chatblade";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [chatblade];
    };
  }
