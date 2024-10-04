{ inputs, ... }:

let
  secretsPath = builtins.toString inputs.nix-secrets;
in {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  
  sops = {
    defaultSopsFile = "${secretsPath}/secrets.yaml";
    validateSopsFiles = false;
    
    age.keyFile = "/home/nacho/.config/sops/age/keys.txt";

    secrets = {
      "users/nacho/ssh_key" = {
        path = "/home/nacho/.ssh/id_ed25519";
      };
      "users/nacho/ssh_key_pub" = {
        path = "/home/nacho/.ssh/id_ed25519.pub";
      };
    };
  };
}
