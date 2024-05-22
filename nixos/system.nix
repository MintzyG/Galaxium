{ lib, config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "galaxium";
  networking.networkmanager.enable = true;

  system.stateVersion = "23.11";
}
