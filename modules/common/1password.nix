{ config
, pkgs
, lib
, user
, dotfiles
, ...
}: {
  options = {
    _1password = {
      enable = lib.mkEnableOption {
        description = "Enable 1Password.";
        default = false;
      };
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs._1password-gui.override { polkitPolicyOwners = [ "${user}" ]; };
      defaultText = lib.literalExpression "pkgs._1password-gui";
      example = lib.literalExpression "pkgs._1password-gui";
      description = ''
        The 1Password derivation to use. This can be used to upgrade from the stable release that we keep in nixpkgs to the betas.
      '';
    };
  };

  config = lib.mkIf config._1password.enable {
    programs = {
      dconf.enable = true;
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "${user}" ];
      };
    };
    environment.systemPackages = with pkgs; [
      _1password
      _1password-gui
    ];
    home-manager.users.${user} = {
      home.file.".config/autostart/1password-startup.desktop".source = "${dotfiles}/autostart/1password-startup.desktop";
    };

    security.wrappers = {
      "1Password-BrowserSupport" = {
        source = "${config.package}/share/1password/1Password-BrowserSupport";
        owner = "root";
        group = "onepassword";
        setuid = false;
        setgid = true;
      };

      "1Password-KeyringHelper" = {
        source = "${config.package}/share/1password/1Password-KeyringHelper";
        owner = "root";
        group = "onepassword";
        setuid = true;
        setgid = true;
      };
    };
  };
}
