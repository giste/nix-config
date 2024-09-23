{config, systemSettings, ...}:

{
  boot = {
    kernelParams = if (systemSettings.gpuType == "nvidia") then
      [ "nvidia_drm.modeset=1" "nvidia_drm.fbdev=1" ]
    else
      [];
    initrd.kernelModules = if (systemSettings.gpuType == "nvidia") then
      [ "nvidia" ]
    else [];
    extraModulePackages = if (systemSettings.gpuType == "nvidia") then
      [ config.boot.kernelPackages.nvidia_x11 ]
    else [];
  };
}
