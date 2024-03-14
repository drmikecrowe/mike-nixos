{
  config,
  lib,
  pkgs,
  secrets,
  ...
}:
with lib; {
  options = {
    host.user.root = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable root";
      };
    };
  };

  config = mkIf config.host.user.root.enable {
    users.users.root = {
      inherit (secrets.root) hashedPassword;
      shell = pkgs.bashInteractive;
    };
  };
}
