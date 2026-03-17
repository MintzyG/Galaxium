{ inputs, pkgs, lib, ... }:

{
  home.packages = [ 
    inputs.quickshell.packages.${pkgs.system}.default 
    pkgs.qt6.qt5compat
    pkgs.qt6Packages.qt6ct
    pkgs.papirus-icon-theme
  ];

  home.sessionVariables = {
    XDG_DATA_DIRS = "${pkgs.papirus-icon-theme}/share:${pkgs.hicolor-icon-theme}/share:$XDG_DATA_DIRS";
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt6ct";
  };

  xdg.configFile."quickshell" = {
    source = ./qs;
    recursive = true;
  };
}
