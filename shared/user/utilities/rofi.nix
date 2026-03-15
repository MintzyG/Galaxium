{ pkgs, config, ... }:

{
  home.packages = [
    pkgs.rofimoji
  ];
  programs.rofi = {
    enable = true;

    plugins = [
      pkgs.rofi-calc
    ];

    extraConfig = {
      modi = "drun,run,window,calc";
      combi-modi = "drun,run,window,calc";
      show-icons = true;
      drun-display-format = "{name}";
      display-drun = "󰣆 Apps";
      display-run = " Run";
      display-window = " Windows";
      display-calc = " Calc";
      terminal = "ghostty";
      kb-cancel = "Escape";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "window" = {
        border-radius = mkLiteral "12px 12px 0px 0px";
        width = mkLiteral "33%";
        height = mkLiteral "50%";
        location = mkLiteral "south";
        anchor = mkLiteral "south";
      };

      "mainbox" = {
        orientation = mkLiteral "vertical";
        children = mkLiteral "[mode-switcher, inputbar, listview]";
        padding = mkLiteral "12px";
      };

      "mode-switcher" = {
        orientation = mkLiteral "horizontal";
        spacing = mkLiteral "4px";
        margin = mkLiteral "0px 0px 8px 0px";
      };

      "button" = {
        border-radius = mkLiteral "6px";
        padding = mkLiteral "4px 12px";
      };

      "button selected" = {
        border-radius = mkLiteral "6px";
        padding = mkLiteral "4px 12px";
      };

      "inputbar" = {
        border-radius = mkLiteral "8px";
        padding = mkLiteral "8px 12px";
        margin = mkLiteral "0px 0px 8px 0px";
        children = mkLiteral "[prompt, entry]";
      };

      "listview" = {
        orientation = mkLiteral "vertical";
        columns = 1;
        lines = 8;
        scrollbar = false;
        spacing = mkLiteral "4px";
      };

      "element" = {
        border-radius = mkLiteral "6px";
        padding = mkLiteral "8px 12px";
        orientation = mkLiteral "horizontal";
        spacing = mkLiteral "8px";
      };

      "element-icon" = {
        size = mkLiteral "20px";
      };

      "element-text" = {
        vertical-align = mkLiteral "0.5";
      };
    };
  };
}
