{ config, ... }:

{
  security.sudo = {
    enable = true;
    extraConfig = ''
      # Use ssh keys from user, not root
      Defaults    env_keep += "SSH_AUTH_SOCK"
    '';
  };
}