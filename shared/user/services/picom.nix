{ lib, ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";

    vSync = true;
    fade = true;
    shadow = true;

    fadeDelta = 5;
    shadowOpacity = 0.2;
    inactiveOpacity = 1.0;

    fadeExclude = [
      "window_type = 'menu'"
      "window_type = 'dropdown_menu'"
      "window_type = 'popup_menu'"
      "window_type = 'tooltip'"
    ];

    opacityRules = [
      "60:class_g = 'Kitty'"
    ];

    settings = {
      # corner-radius = 5;
      # round-borders = 5;

      inactiveDim = 0.40;

      blur = {
        method = "gaussian";
        size = 10;
        deviation = 5.0;
      };
    };
  };

  systemd.user.services.picom = lib.mkForce { };
}
