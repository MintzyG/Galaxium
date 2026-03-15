{ inputs, pkgs, ... }:

{
  home.packages = [ inputs.quickshell.packages.${pkgs.system}.default ];

  xdg.configFile."quickshell" = {
    source = ./qs;
    recursive = true;
  };
}
