{ config, lib, ... }:

{
  options = {
    gpu = lib.mkOption {
      type = lib.types.str;
      description = "GPU of the host";
      default = "";
    };
  };

  config = {
    boot = {
      kernelParams = if (config.gpu == "nvidia") then
          [ "nvidia_drm.modeset=1" "nvidia_drm.fbdev=1" ]
        else
          [];
      initrd.kernelModules = if (config.gpu == "nvidia") then
          [ "nvidia" ]
        else
          [];
      extraModulePackages = if (config.gpu == "nvidia") then
          [ config.boot.kernelPackages.nvidia_x11 ]
        else
          [];
    };
  };
}
