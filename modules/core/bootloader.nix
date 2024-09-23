{ config, lib, ... }:

{
  # Use the systemd-boot boot loader.
  boot.loader = {
    systemd-boot.enable = lib.mkDefault true;
    efi.canTouchEfiVariables = lib.mkDefault true;
    timeout = lib.mkDefault 2;
  };
}