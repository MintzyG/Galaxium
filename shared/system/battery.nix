{
  services = {
    system76-scheduler.settings.cfsProfiles.enable = true;

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
           governor = "performance";
           turbo = "auto";
        };
        charger = {
           governor = "performance";
           turbo = "auto";
        };
      };
    };

    power-profiles-daemon.enable = false;
    thermald.enable = true;
  };
}
