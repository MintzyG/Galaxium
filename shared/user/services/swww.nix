{ pkgs, ... }:
{
  systemd.user.services.swww = {
    Unit = {
      Description = "Sww Daemon";
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon -q --format xrgb";
      Restart = "no";
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  home.packages = with pkgs; [
    swww
  ];
}
