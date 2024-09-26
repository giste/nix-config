{ config, lib, ... }:

{
  config.home-manager.users = builtins.listToAttrs (
    map 
      (user: lib.nameValuePair user.login (import ./${user.login}))
      config.host.users
  );
}