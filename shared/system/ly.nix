{ pkgs-stable, ... }:
{
  services.displayManager.ly = {
    enable = true;
    package = pkgs-stable.ly;
    settings = {
      animation = "doom";
      clock = "%d/%m/%y - %R";
      xinitrc = "null";
    };
  };
}
