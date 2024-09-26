{

  description = "My first flake";

  inputs = {
    ###### Nix packages ######
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";

    ###### Home Manager ######
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    ###### SOPS - secret management ######
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs-stable";
      };
    };

    ###### Secrets repo ######
    nix-secrets = {
      url = "git+ssh://git@github.com/giste/nix-secrets.git?shallow=1&ref=main";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, home-manager-stable, sops-nix, ... }:
  let
    # ------ System settings ------ 
    systemSettings = {
      system = "x86_64-linux"; # system arch
      hostName = "nixos"; # hostname
      timeZone = "Europe/Madrid"; # select timezone
      locale = "es_ES.UTF-8"; # select locale
      layout = "es"; # keyboard layout
      efiMount = "/boot"; # mount path for efi boot partition
      gpuType = "nvidia"; # amd, intel or nvidia
      wm = "gnome"; # window manager to use
    };
    
    # ------ User settings ------
    userSettings = {
      userName = "nacho"; # login name
      name = "Nacho"; # name to show
      gitName = "Giste";
      gitEmail = "giste.trappiste@gmail.com";
      dotFilesDir = "/home/nacho/.dotfiles"; # dir for config files
    };
    
    # system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${systemSettings.system};
  in {
    nixosConfigurations = {

      nixos = let
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
          ./hosts/idefix
          home-manager-stable.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            #home-manager.users.nacho = import ./user/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
            home-manager.extraSpecialArgs = {
              inherit systemSettings;
              inherit userSettings;
            };
          }
        ];
        specialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
      };

    };

    homeConfigurations = {
      nacho = home-manager-stable.lib.homeManagerConfiguration {
        #inherit pkgs;
        pkgs = import inputs.nixpkgs-stable {
          system = systemSettings.system;
          config = {
            allowUnfree = true;
          };
        };
        modules = [ ./user/home.nix ];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
  };

}
