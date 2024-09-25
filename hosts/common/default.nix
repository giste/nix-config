{ config, lib, pkgs, ... }:

{
  options = {
    host = with lib; {
      name = mkOption {
        type = types.str;
        description = "Name of the host";
      };

      stateVersion = mkOption {
        type = types.str;
        description = "First version of NixOS installed on this host.";
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
    ../../modules/core
  ];

  config = {
    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = config.host.stateVersion; # Did you read the comment?

  };
}