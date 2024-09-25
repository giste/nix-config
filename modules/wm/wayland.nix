{ config, systemSettings, ... }:

{
  imports = [
    ../hardware/opengl.nix
  ];
  
  services.xserver = {
    enable = true;
    xkb = {
      layout = systemSettings.layout;
      model = "pc105";
      options = "eurosign:e";
    };
    videoDrivers = [ systemSettings.gpuType ];
  };
}
