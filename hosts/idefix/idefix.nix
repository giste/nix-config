# Idefix main configuration.
{ config, lib, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
    ./hardware-configuration.nix # HW configuration
    ../../modules/core
    ../../modules/hardware/gpu/nvidia.nix
    #../../modules/hardware/kernel.nix
    ../../system/wm/gnome.nix
  ];

  # Define config options.
  hostname = "nixos";
  #gpu = "nvidia";
  hostUsers = [
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
  
  # sops.secrets = {
  #   "users/${userSettings.userName}/passwd".neededForUsers = true;
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users = {
  #   mutableUsers = false;
  #   users.${userSettings.userName} = {
  #     description = userSettings.name;
  #     uid = 1000;
  #     isNormalUser = true;
  #     # initialPassword = "qwerty01";
  #     hashedPasswordFile = config.sops.secrets."users/${userSettings.userName}/passwd".path;
  #     extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  #     packages = with pkgs; [];
  #   }; 
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
  ];

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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

