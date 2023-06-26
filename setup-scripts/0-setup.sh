mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

if ! command -v git; then nix-env -f '<nixpkgs>' -iA git; fi
if ! command -v jq;  then nix-env -f '<nixpkgs>' -iA jq; fi
if ! command -v partprobe;  then nix-env -f '<nixpkgs>' -iA parted; fi