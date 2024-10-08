{

  description = "My first flake";

  inputs = {
    ###### Nix packages ######
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";

    ###### Home Manager ######
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    ###### SOPS - secret management ######
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        nixpkgs-stable.follows = "nixpkgs-stable";
      };
    };

    ###### Secrets repo ######
    nix-secrets = {
      url = "git+ssh://git@github.com/giste/nix-secrets.git?shallow=1&ref=main";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs-unstable, nixpkgs-stable, home-manager-unstable, home-manager-stable, sops-nix, ... }:
  {
    nixosConfigurations = {

      nixos = let
        system = "x86_64-linux";
        # Set channel for packages and home-manager
        nixPackages = nixpkgs-stable;
        homeManager = home-manager-stable;
        pkgs = import nixPackages {
          inherit system;
          config.allowUnfree = true;
        };
        inherit (nixPackages) lib;
      in lib.nixosSystem {
        inherit system pkgs lib;
        modules = [ 
          ./hosts/idefix
          homeManager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };

    };

  #   homeConfigurations = {
  #     nacho = home-manager-stable.lib.homeManagerConfiguration {
  #       #inherit pkgs;
  #       pkgs = import inputs.nixpkgs-stable {
  #         system = systemSettings.system;
  #         config = {
  #           allowUnfree = true;
  #         };
  #       };
  #       modules = [ ./user/home.nix ];
  #       extraSpecialArgs = {
  #         inherit systemSettings;
  #         inherit userSettings;
  #       };
  #     };
  #   };
  };

}
