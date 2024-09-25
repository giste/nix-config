{ config, lib, inputs, ... }:

{
  config = {
    sops.secrets = builtins.listToAttrs (map (user: lib.nameValuePair "users/${user.login}/passwd" {
      neededForUsers = true;
    }) config.host.users);

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
      }) config.host.users);
    };
  };

}