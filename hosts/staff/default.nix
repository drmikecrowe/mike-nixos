# The Staff
# ISO configuration for my USB drive

{ inputs, system, overlays, ... }:

inputs.nixos-generators.nixosGenerate {
  inherit system;
  format = "install-iso";
  modules = [{
    nixpkgs.overlays = overlays;
    users.extraUsers.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBYgTeDDgeD1RjH9t+gCzfRFBNjiWWPzll/8yOlVxmNh"
    ];
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      allowSFTP = true;
      settings = {
        GatewayPorts = "no";
        X11Forwarding = false;
        PasswordAuthentication = false;
        PermitRootLogin = "yes";
      };
      hostKeys = [
        {
          bits = 4096;
          openSSHFormat = true;
          path = "/etc/ssh/ssh_host_rsa_key";
          rounds = 100;
          type = "rsa";
        }
        {
          comment = "key comment";
          path = "/etc/ssh/ssh_host_ed25519_key";
          rounds = 100;
          type = "ed25519";
        }
      ];
    };
    environment.systemPackages =
      let pkgs = import inputs.nixpkgs { inherit system overlays; };
      in
      with pkgs; [
        git
        vim
        wget
        curl
        (import ../../modules/common/neovim/package {
          inherit pkgs;
          colors = (import ../../colorscheme/gruvbox).dark;
        })
      ];
    nix.extraOptions = ''
      experimental-features = nix-command flakes
      warn-dirty = false
    '';
  }];
}
