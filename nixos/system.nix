{ lib, config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "galaxium";
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    home-manager
    nix-index
  ];

  system.stateVersion = "23.11";
}
