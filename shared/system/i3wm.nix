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
      defaultSession = "none+i3";
    };
    xkb = {
      layout = "br";
    };
  };
}
