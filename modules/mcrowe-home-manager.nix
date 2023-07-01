{ inputs, outputs, ... }: {
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      # Note: this assumes you have a `default.nix` in your home-manager directory.
      # If not replace with `your-username = import ../home-manager/home.nix` 
      mcrowe = import ../home-manager/home.nix;
    };
  };
}
