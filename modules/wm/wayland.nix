{ config, lib, ... }:

{
  imports = [
    ../hardware/graphics.nix
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
