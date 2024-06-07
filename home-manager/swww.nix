{ pkgs, ... }:
{
  systemd.user.services.swww = {
    Unit = {
      Description = "Sww Daemon";
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon --format xrgb";
      Restart = "no";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
