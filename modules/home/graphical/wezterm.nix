{
  dotfiles,
  lib,
  custom,
  ...
}: {
  home.file.".config/wezterm" = {
    source = "${dotfiles}/wezterm";
    recursive = true;
  };
}
