{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia.nix
	  ./sound.nix
	  ./video.nix
	  ./games.nix
	  ./user.nix
	  ./apps.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command"  "flakes" ];
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];
  
  fonts.packages = with pkgs; [ 
    jetbrains-mono
    noto-fonts-emoji
    nerdfonts
  ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
