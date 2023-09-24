{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    passwordHash = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "Password created with mkpasswd -m sha-512";
      default = null;
      # Test it by running: mkpasswd -m sha-512 --salt "5Tj4qS0.LiGi8DIf"
    };
  };

  config = lib.mkIf pkgs.stdenv.isLinux {
    # Allows us to declaritively set password
    users.mutableUsers = false;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${config.user} = {
      # Create a home directory for human user
      isNormalUser = true;

      # Automatically create a password to start
      hashedPassword = config.passwordHash;
      uid = 1000;

      extraGroups = [
        "wheel" # Sudo privileges
        "audio"
        "video"
        "bluetooth"
        "networkmanager"
        "docker"
        "libvirtd"
      ];
    };

    home-manager.users.${config.user}.xdg = {
      # Allow Nix to manage the default applications list
      mimeApps.enable = true;

      # Set directories for application defaults
      userDirs = {
        enable = true;
        createDirectories = true;
        templates = "$HOME/other/templates";
      };
    };
  };
}
