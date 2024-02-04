{
  config,
  lib,
  user,
  ...
}: {
  options = {
    publicKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "Public SSH key authorized for this system.";
      default = null;
    };
    permitRootLogin = lib.mkOption {
      type = lib.types.str;
      description = "Root login settings.";
      default = "no";
    };
  };

  config = lib.mkIf (config.publicKey != null) {
    services.openssh = {
      enable = true;
    };

    users.users.${user}.openssh.authorizedKeys.keys = [config.publicKey];

    # Implement a simple fail2ban service for sshd
    services.sshguard.enable = true;

    # Add terminfo for SSH from popular terminal emulators
    environment.enableAllTerminfo = true;
  };
}
