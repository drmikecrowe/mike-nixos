{ config
, pkgs
, lib
, secrets
, user
, ...
}: {
  config = lib.mkIf pkgs.stdenv.isLinux {
    # Allows us to declaritively set password
    users.mutableUsers = false;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${user} = {
      # Create a home directory for human user
      isNormalUser = true;

      # Automatically create a password to start
      hashedPassword = secrets.${user}.passwordHash;
      uid = 1000;

      extraGroups = [
        "wheel" # Sudo privileges
        "audio"
        "video"
        "bluetooth"
        "networkmanager"
      ];
    };
  };
}
