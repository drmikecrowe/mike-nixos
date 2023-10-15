{ config
, pkgs
, lib
, user
, dotfiles
, ...
}: {
  config = lib.mkIf config.custom._1password.enable {
    programs = {
      dconf.enable = true;
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "${user}" ];
      };
    };
    home-manager.users.${user} = {
      home.file.".config/autostart/1password-startup.desktop".source = "${dotfiles}/autostart/1password-startup.desktop";
    };

    security.wrappers = {
      "1Password-BrowserSupport" = {
        source = "${config.custom._1password.package}/share/1password/1Password-BrowserSupport";
        owner = "root";
        group = "onepassword";
        setuid = false;
        setgid = true;
      };

      "1Password-KeyringHelper" = {
        source = "${config.custom._1password.package}/share/1password/1Password-KeyringHelper";
        owner = "root";
        group = "onepassword";
        setuid = true;
        setgid = true;
      };
    };
  };
}
