{ config, lib, pkgs, ... }:

{
  imports = [
    ./wayland.nix
    ./pipewire.nix
  ];
  
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = lib.mkDefault true;
  services.xserver.desktopManager.gnome.enable = lib.mkDefault true;
  
  xdg.portal = {
    enable = lib.mkDefault true;
    extraPortals = lib.mkDefault [ pkgs.xdg-desktop-portal-gnome ];
  };
  
  environment.systemPackages = lib.mkDefault [
    pkgs.xdg-desktop-portal-gnome
  ];
}
