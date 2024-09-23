{ inputs, config, lib, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  
  sops = {
    defaultSopsFile = lib.mkDefault ../../secrets/secrets.yaml;
    validateSopsFiles = lib.mkDefault false;
    
    age = {
      sshKeyPaths = lib.mkDefault [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = lib.mkDefault "/var/lib/sops-nix/key.txt";
      generateKey = lib.mkDefault true;
    };
  };
}
