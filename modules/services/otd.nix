{ pkgs, ... }:
{
  systemd.user.services.otd-daemon = {
    Unit = {
      Description = "OpenTabletDriver Daemon";
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.opentabletdriver}/bin/otd-daemon";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
