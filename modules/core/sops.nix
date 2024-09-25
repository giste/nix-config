{ inputs, config, lib, ... }:

let
  secretsPath = builtins.toString inputs.nix-secrets;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  
  sops = {
    defaultSopsFile = lib.mkDefault "${secretsPath}/secrets.yaml";
    validateSopsFiles = lib.mkDefault false;
    
    age = {
      sshKeyPaths = lib.mkDefault [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = lib.mkDefault "/var/lib/sops-nix/key.txt";
      generateKey = lib.mkDefault true;
    };
  };
}
