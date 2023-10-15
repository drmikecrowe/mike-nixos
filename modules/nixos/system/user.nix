{ custom
, pkgs
, lib
, user
, ...
}: {
  config = lib.mkIf pkgs.stdenv.isLinux {
    # Allows us to declaritively set password
    users.mutableUsers = false;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${user} = {
      inherit (custom.secrets.${user}) hashedPassword;
      # Create a home directory for human user
      isNormalUser = true;

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
