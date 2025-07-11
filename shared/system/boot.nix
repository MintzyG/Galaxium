{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      logo = ../../catppuccin-mocha-rainbow.png;
    };
  };

  environment.systemPackages = with pkgs; [
    efibootmgr
  ];
}
