{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        dmenu
      ];
    };
    displayManager = {
      lightdm.enable = true;
    };
    xkb = {
      layout = "br";
    };
  };

  services.displayManager.defaultSession = "none+i3";
}
