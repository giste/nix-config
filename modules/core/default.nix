{ ... }:

{
  imports = [
    ./bootloader.nix
    ./timezone.nix
    ./networking.nix
    ./locale.nix
    ./nix.nix
    ./packages.nix
    ./sops.nix
    ./users.nix
    ./sudo.nix
  ];
}