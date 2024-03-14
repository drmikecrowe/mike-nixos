#!/usr/bin/env bash

cat <<EOF > $2/$1.nix
{config, lib, pkgs, ...}:
let
  cfg = config.host.application.$1;
in
  with lib;
{
  options = {
    host.application.$1 = {
      enable = mkOption {
        default = true;
        type = with types; bool;
        description = "Enables $1";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [$1];
  };
}

EOF