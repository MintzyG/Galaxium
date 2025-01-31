{ config, inputs, lib, pkgs, ... }:
let
  generateScss = ''
    $bg: #282a36;      // Background
    $border: #44475a;  // Current Line / Selection
    $text: #f8f8f2;    // Foreground (Text)
    $main: #bd93f9;    // Accent (Purple)
  '';

  ags = inputs.ags.packages.${pkgs.system};
  deps = [
    ags.battery
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
    configDir = ../ags;
    package = ags.agsFull.overrideAttrs {
      postFixup = ''wrapProgram $out/bin/ags --prefix PATH : ${lib.makeBinPath deps}'';
    };
    extraPackages = deps ++ [
      pkgs.pwvucontrol
    ];
  };

  home.file."${config.home.homeDirectory}/.config/galaxium/shared/user/ags/bar/variables.scss".text = generateScss;

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
