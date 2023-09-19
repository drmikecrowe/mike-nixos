{ config, pkgs, lib, ... }: {

  config = {
    # Basic common system packages for all devices
    environment.systemPackages = with pkgs; [
      black # Python formatter
      curl
      git
      nodePackages.pyright # Python language server
      nodejs_18
      parted
      pciutils
      poetry
      python310Full
      python310Packages.flake8 # Python linter
      python310Packages.mypy # Python linter
      python310Packages.pip
      python310Packages.poetry-core
      python310Packages.pynvim
      sysz
      vim
      wget
      vscode
    ];
  };
}
