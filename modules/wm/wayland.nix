{ config, lib, ... }:

{
  imports = [
    ../hardware/opengl.nix
  ];
  
  services.xserver = {
    enable = true;
    xkb = {
      layout = lib.mkDefault "es";
      model = lib.mkDefault "pc105";
      options = lib.mkDefault "eurosign:e";
    };
  };
}
