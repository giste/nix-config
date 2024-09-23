{ config, lib, inputs, ... }:

{
  options = {
    hostUsers = lib.mkOption {
      description = "Users to create in the host.";
      type = lib.types.listOf (lib.types.submodule {
        options = {
          login = lib.mkOption {
            type = lib.types.str;
            description = "Login name of the user.";
          };
          name = lib.mkOption {
            type = lib.types.str;
            description = "User name to show.";
            default = "";
          };
          uid = lib.mkOption {
            type = lib.types.nullOr lib.types.int;
            description = "User UID";
            default = null;
          };
          extraGroups = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = "Additional groups of this user.";
            default = [];
          };
        };
      });
    };
  };

  config = {
    sops.secrets = builtins.listToAttrs (map (user: lib.nameValuePair "users/${user.login}/passwd" {
      neededForUsers = true;
    }) config.hostUsers);

    users = {
      # Users managed by config.
      mutableUsers = false;

      users = builtins.listToAttrs (map  (user: lib.nameValuePair user.login {
        isNormalUser = true;
        description = user.name;
        uid = user.uid;
        password = "nixos"; # Overridden if sops is working
        hashedPasswordFile = config.sops.secrets."users/${user.login}/passwd".path;
        extraGroups = user.extraGroups; 
      }) config.hostUsers);
    };
  };

}