{ pkgs, ... }:

{
  services = {
    system76-scheduler.settings.cfsProfiles.enable = true;

    # tlp = {
    #   enable = true;
    #   settings = {
    #     CPU_BOOST_ON_AC = 1;
    #     CPU_BOOST_ON_BAT = 0;
    #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
    #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    #     CPU_ENERGY_PERF_POLICY_ON_BAt = "power";
    #
    #     CPU_MIN_PERF_ON_AC = 0;
    #     CPU_MAX_PERF_ON_AC = 100;
    #     CPU_MIN_PERF_ON_BAT = 0;
    #     CPU_MAX_PERF_ON_BAT = 50;
    #   };
    # };

    power-profiles-daemon.enable = false;
    thermald.enable = true;
  };

  powerManagement.powertop.enable = true;

  environment.systemPackages = with pkgs; [
    powertop
  ];
}
