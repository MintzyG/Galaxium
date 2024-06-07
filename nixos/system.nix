{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "galaxium";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  hardware.opentabletdriver.enable = true;

  system.stateVersion = "23.11";
}
