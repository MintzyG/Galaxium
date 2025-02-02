{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "breeze";
      logo = ../../catppuccin-mocha-rainbow.png;
    };
  };

  environment.systemPackages = with pkgs; [
    efibootmgr
  ];
}
