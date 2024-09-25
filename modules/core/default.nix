{ config, lib, ... }:

{
  options = {
    host = with lib; {
      name = mkOption {
        type = types.str;
        description = "Name of the host";
      };

      type = mkOption {
        type = types.enum [ "server" "desktop" ];
        description = "Host type: server | desktop";
        default = "server";
      };

      users = mkOption {
        description = "Users to create in the host.";
        type = types.listOf (types.submodule {
          options = {
            login = mkOption {
              type = types.str;
              description = "Login name of the user.";
            };
            name = mkOption {
              type = types.str;
              description = "User name to show.";
              default = "";
            };
            uid = mkOption {
              type = types.nullOr types.int;
              description = "User UID";
              default = null;
            };
            extraGroups = mkOption {
              type = types.listOf types.str;
              description = "Additional groups of this user.";
              default = [];
            };
          };
        });
      };
    };
  };

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