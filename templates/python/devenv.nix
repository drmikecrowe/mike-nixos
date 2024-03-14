{
  pkgs,
  config,
  ...
}: {
  packages = [
    # A native dependency of numpy
  ];
  languages.python = {
    enable = true;
    version = "3.11.5";
    poetry.enable = true;
  };
}
