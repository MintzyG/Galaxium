{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../shared/system/battery.nix
    ../../shared/system/bluetooth.nix
    ../../shared/system/boot.nix
    ../../shared/system/fonts.nix
    ../../shared/system/locale.nix
    ../../shared/system/nix.nix
    ../../shared/system/nvidia.nix
    ../../shared/system/opentabletdriver.nix
    ../../shared/system/postgres.nix
    ../../shared/system/security.nix
    ../../shared/system/sound.nix
    ../../shared/system/steam.nix
    ../../shared/system/i3wm.nix
  ];

  networking = {
  # Change Hostname
    hostName = "galaxium";
    networkmanager.enable = true;
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  # Change Config name
  # FLAKE = "/home/sophia/.config/galaxium";
  };

  programs.fish.enable = true;
  # Change User Name
  users.users.sophia = {
    isNormalUser = true;
    description = "X11 System";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
    shell = pkgs.fish;
  };

  system.stateVersion = "24.05";
}
