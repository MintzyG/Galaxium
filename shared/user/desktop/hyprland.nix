{ pkgs, lib, ... }:

let
  print = import ../../../scripts/print.nix { inherit pkgs; };
  printSelection = import ../../../scripts/printSelection.nix { inherit pkgs; };
  Wallpaper = import ../../../scripts/wallpaper.nix { inherit pkgs; };
  closespecial = pkgs.writeShellScriptBin "closespecial" ''
    active=$(hyprctl -j monitors | ${pkgs.jq}/bin/jq --raw-output '.[] | select(.focused==true).specialWorkspace.name | split(":") | if length > 1 then .[1] else "" end')
    if [[ ''${#active} -gt 0 ]]; then
      hyprctl dispatch togglespecialworkspace "$active"
    fi
    '';
    cliphist-img = pkgs.writeShellScriptBin "cliphist-img" ''
    TMP=$(mktemp -d /tmp/cliphist-XXXXXX)
    trap "rm -rf $TMP" EXIT

    ${pkgs.cliphist}/bin/cliphist list | while IFS=$'\t' read -r id content; do
      ${pkgs.cliphist}/bin/cliphist decode <<< "$id"$'\t'"$content" > "$TMP/$id.data" 2>/dev/null
      mime=$(${pkgs.file}/bin/file --mime-type -b "$TMP/$id.data")
      if [[ "$mime" == image/* ]]; then
        ${pkgs.imagemagick}/bin/convert "$TMP/$id.data" -thumbnail 64x64^ -gravity center -extent 64x64 "$TMP/$id.png" 2>/dev/null
        echo -e "$id\t[image]\0icon\x1f$TMP/$id.png"
      else
        echo -e "$id\t$content"
      fi
    done | rofi -dmenu -display-columns 2 | {
      read -r sel
      ${pkgs.cliphist}/bin/cliphist decode <<< "$sel" | ${pkgs.wl-clipboard}/bin/wl-copy
      ${pkgs.wl-clipboard}/bin/wl-paste
    }
  '';
in
  {
  home.packages = [
    print
    Wallpaper
    closespecial
    cliphist-img
    pkgs.cliphist
    pkgs.imagemagick
    pkgs.wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      monitor = [
        "eDP-1, 1920x1080@120, 0x0, 1"
        "eDP-2, preferred@120, auto, 1"
      ];

      workspace = [
        "1, monitor:eDP-1, layout:scrolling"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1, layout:scrolling"
        "4, monitor:eDP-1"
        "5, monitor:eDP-1"
        "6, monitor:eDP-1"
        "7, monitor:eDP-1"
        "8, monitor:eDP-1"
        "9, monitor:eDP-1"
        "10, monitor:eDP-1"
        "special:comms, on-created-empty:vesktop & whatsapp-electron & Telegram, layout:scrolling"
        "special:music, on-created-empty:spotify"
        "special:sysmon, on-created-empty:$TERMINAL -e btop"
        "special:zen, on-created-empty:zen-beta, layout:scrolling"
      ];

      env = "XCURSOR_SIZE, 24";

      input = {
        kb_layout = "br";
        kb_variant = "abnt2";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = "no";
        };

        # Goes from -1.0 to 1.0
        sensitivity = 0;
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;

        layout = "dwindle";

        allow_tearing = false;
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      animations = {
        enabled = "yes";

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_status = "master";
      };

      scrolling = {
        column_width = 1.0;
        direction = "right";
        focus_fit_method = 1;
      };

      misc = {
        force_default_wallpaper = "-1";
      };

      "$mainMod" = "SUPER";

      bind = lib.mkAfter [
        "$mainMod, Return, exec, $TERMINAL"
        "$mainMod, Q, killactive,"
        "$mainMod, E, exec, dolphin"
        "$mainMod, V, togglefloating,"
        "$mainMod, F, fullscreen,"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, H, exec, ${cliphist-img}/bin/cliphist-img"
        "$mainMod, J, togglesplit,"
        "$mainMod SHIFT, L, exec, hyprlock"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod SHIFT, M, exit,"

        "$mainMod, Tab, exec, rofi -show window"
        "$mainMod, period, exec, rofimoji"
        "$mainMod, equal, exec, rofi -show calc -no-show-match -no-sort"

        "ALT, TAB, cyclenext, , currentworkspace"
        "ALT SHIFT, TAB, cyclenext, prev, currentworkspace"
        "$mainMod ALT, TAB, workspace, e+1"
        "$mainMod ALT SHIFT, TAB, workspace, e-1"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 1, exec, ${closespecial}/bin/closespecial"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 2, exec, ${closespecial}/bin/closespecial"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 3, exec, ${closespecial}/bin/closespecial"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 4, exec, ${closespecial}/bin/closespecial"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 5, exec, ${closespecial}/bin/closespecial"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 6, exec, ${closespecial}/bin/closespecial"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 7, exec, ${closespecial}/bin/closespecial"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 8, exec, ${closespecial}/bin/closespecial"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 9, exec, ${closespecial}/bin/closespecial"
        "$mainMod, 0, workspace, 10"
        "$mainMod, 0, exec, ${closespecial}/bin/closespecial"
        "$mainMod, Escape, exec, ${closespecial}/bin/closespecial"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, C, togglespecialworkspace, comms"
        "$mainMod SHIFT, C, movetoworkspace, special:comms"

        "$mainMod, S, togglespecialworkspace, music"
        "$mainMod SHIFT, S, movetoworkspace, special:music"

        "$mainMod, W, togglespecialworkspace, zen"
        "$mainMod SHIFT, W, movetoworkspace, special:zen"

        "CTRL SHIFT, Escape, togglespecialworkspace, sysmon"

        "$mainMod SHIFT, P, exec, ${print}/bin/print"
        "$mainMod, P, exec, ${printSelection}/bin/printSelection"
        "$mainMod, B, exec, ${Wallpaper}/bin/Wallpaper"

        "$mainMod, mouse_down, layoutmsg, move +col"
        "$mainMod, mouse_up, layoutmsg, move -col"

        "$mainMod, F1, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      binde = [
        "$mainMod, F2, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        "$mainMod, F3, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        "$mainMod, F4, exec, brightnessctl set 5%-"
        "$mainMod, F5, exec, brightnessctl set 5%+"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrule = [
        "size 640 360, match:title ^(Picture-in-Picture)$"
        "move monitor_w-660 monitor_h-380, match:title ^(Picture-in-Picture)$"
      ];

      exec-once = [ 
        "${Wallpaper}/bin/Wallpaper" 
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];
    };
  };
}
