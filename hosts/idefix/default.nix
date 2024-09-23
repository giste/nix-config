{ inputs, systemSettings, userSettings, ... }:

with inputs;

let
  system = "x86_64-linux";
  # Set nixpkgs-channel to nixpkgs or nixpkgs-stable
  nixpackages = nixpkgs-stable;
  pkgs = import nixpackages {
    inherit system;
    config.allowUnfree = true;
  };
  lib = pkgs.lib;
in nixpackages.lib.nixosSystem {
  inherit system pkgs lib;
  modules = [ 
    ./idefix.nix
  ];
  specialArgs = {
    inherit systemSettings;
    inherit userSettings;
    inherit inputs;
  };
}