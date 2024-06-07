{ pkgs, ... }:

{
  services = {
    system76-scheduler.settings.cfsProfiles.enable = true;

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
           governor = "powersave";
           turbo = "never";
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

  powerManagement.powertop.enable = true;
  environment.systemPackages = with pkgs; [
    powertop
  ];
}
