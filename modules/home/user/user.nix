{ pkgs, ... }:

{
  home = {
    username = "sophia";
    homeDirectory = "/home/sophia/";

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";

      FLAKE = "/home/sophia/galaxium";
    };
  };

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
    };

    portal = {
      enable = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];

      configPackages = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    };
  };
}
