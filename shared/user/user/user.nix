{ pkgs, ... }:

{
  home = {
    username = "sophia";
    homeDirectory = "/home/sophia/";

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";

      FLAKE = "/home/sophia/.config/galaxium";
    };
  };

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
    };
  };
}
