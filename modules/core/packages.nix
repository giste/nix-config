{ config, pkgs, ... }:

{
  # System packages for all hosts
  environment.systemPackages = with pkgs; [
    nano
    git
    wget
    curl
  ];
}