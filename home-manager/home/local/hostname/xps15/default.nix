{
  config,
  lib,
  ...
}:
with lib; {
  host = {
    home = {
      applications = {
        albert.enable = mkDefault true;
        alejandra.enable = mkDefault true;
        atool.enable = mkDefault true;
        authy.enable = mkDefault false; # TODO: I think this is broken
        aws-sso-cli.enable = mkDefault true;
        bc.enable = mkDefault true;
        bcompare.enable = mkDefault true;
        betterbird.enable = mkDefault true;
        codeium.enable = mkDefault true;
        copyq.enable = mkDefault true;
        dbeaver.enable = mkDefault true;
        dconf2nix.enable = mkDefault true;
        deno.enable = mkDefault true;
        dig.enable = mkDefault true;
        element-desktop.enable = mkDefault true;
        flameshot.enable = mkDefault true;
        gimp.enable = mkDefault true;
        gnupg.enable = mkDefault true;
        hifile.enable = mkDefault true;
        git-crypt.enable = mkDefault true;
        gitlab-runner.enable = mkDefault true;
        glab.enable = mkDefault true;
        glow.enable = mkDefault true;
        glxinfo.enable = mkDefault true;
        imagemagick.enable = mkDefault true;
        inetutils.enable = mkDefault true;
        kgpg.enable = mkDefault true;
        kitty.enable = mkDefault true;
        libreoffice.enable = mkDefault true;
        meld.enable = mkDefault true;
        miller.enable = mkDefault true;
        nixd.enable = mkDefault true;
        nmap.enable = mkDefault true;
        obsidian.enable = mkDefault true;
        peek.enable = mkDefault true;
        qcad.enable = mkDefault true;
        sd.enable = mkDefault true;
        starship.enable = mkDefault true;
        tealdeer.enable = mkDefault true;
        teams-for-linux.enable = mkDefault true;
        vscode.enable = mkDefault true;
        wavebox.enable = mkDefault true;
        wezterm.enable = mkDefault true;
        yubikey-manager.enable = mkDefault true;
        yubikey-personalization-gui.enable = mkDefault true;
        yubioath-flutter.enable = mkDefault true;
        zoom-us.enable = mkDefault true;
      };
      feature = {
        fonts = {
          enable = mkDefault true;
        };
        mime.defaults = {
          enable = mkDefault true;
        };
        theming = {
          enable = mkDefault true;
        };
        ssh = {
          enable = mkDefault true;
        };
        emulation = {
          windows.enable = mkDefault true;
        };
        virtualization = {
          flatpak.enable = mkForce true;
        };
        gui = {
          enable = mkDefault true;
          displayServer = "x";
          desktopEnvironment = "gnome";
        };
      };
    };
  };
}
