{dotfiles, ...}: {
  imports = [
    ./applications
    ./desktop
    ./feature
    ./users
  ];
}
