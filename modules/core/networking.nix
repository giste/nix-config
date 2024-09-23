{ config, lib, ... }:

{
  options = {
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "Name of the host";
      #default = "nixos";
    };
  };

  config = {
    # Define your hostname.
    networking.hostName = config.hostname;

    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = lib.mkDefault true;  # Easiest to use and most distros use this by default.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}