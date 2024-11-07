{ pkgs, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    script = "polybar example &";
    config = ./polybar.ini;
  };
}
