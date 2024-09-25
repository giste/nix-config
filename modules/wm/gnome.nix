{ config, pkgs, ... }:

{
  imports = [
    ./wayland.nix
    ./pipewire.nix
  ];
  
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };
  
  environment.systemPackages = [
    pkgs.xdg-desktop-portal-gnome
  ];
}
