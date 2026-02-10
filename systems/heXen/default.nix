{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../shared/system/battery.nix
    ../../shared/system/bluetooth.nix
    ../../shared/system/boot.nix
    ../../shared/system/docker.nix
    ../../shared/system/fonts.nix
    ../../shared/system/locale.nix
    ../../shared/system/nix.nix
    ../../shared/system/nvidia.nix
    ../../shared/system/opentabletdriver.nix
    ../../shared/system/security.nix
    ../../shared/system/sound.nix
    ../../shared/system/steam.nix
    ../../shared/system/stylix.nix
  ];

  networking = {
    hostName = "heXen";
    networkmanager.enable = true;
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "zen";
    TERMINAL = "ghostty";
    NH_FLAKE = "${config.users.users.sophia.home}/.config/galaxium";
  };

  programs.hyprland.enable = true;
  programs.fish.enable = true;
  users.users.sophia = {
    isNormalUser = true;
    description = "Sophia";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    home-manager
    nh
  ];

  system.stateVersion = "25.11";
}
