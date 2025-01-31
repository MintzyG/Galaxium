{ config, inputs, lib, pkgs, ... }:
let
  ags = inputs.ags.packages.${pkgs.system};
  deps = [
    ags.apps
    ags.battery
    ags.bluetooth
    ags.hyprland
    ags.mpris
    ags.network
    ags.tray
    ags.wireplumber
  ];
in
  {
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
    configDir = ../ags/bar;
    package = ags.agsFull.overrideAttrs {
      postFixup = ''wrapProgram $out/bin/ags --prefix PATH : ${lib.makeBinPath deps}'';
    };
    extraPackages = deps ++ [
      pkgs.pwvucontrol
    ];
  };

  systemd.user.services.ags-bar = {
    Unit = {
      Description = "AGS Bar";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service =
      let
        ags = "${config.programs.ags.package}/bin/ags";
      in
        {
        ExecStart = "${ags} run";
        ExecReload = "${ags} quit && ${ags} run";
        Restart = "on-failure";
        KillMode = "mixed";
      };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
