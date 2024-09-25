# Idefix main configuration.
{ config, lib, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
    ./hardware-configuration.nix # HW configuration
    ../common
    #../../modules/core
    ../../modules/hardware/gpu/nvidia.nix
    ../../modules/wm/gnome.nix
  ];

  # Define config options.
  host = {
    name = "nixos";
    stateVersion = "24.05";
    gpu = "nvidia";
    users = [
      {
        login = "nacho";
        name = "Nacho";
        uid = 1000;
        extraGroups = [ "wheel" "networkmanager" ];
      }
      {
        login = "gemma";
        name = "Gemma";
        extraGroups = [ "networkmanager" ];
      }
    ];
  };

  
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
