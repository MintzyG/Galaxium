{ lib, config, packages, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;

    settings = {
      monitor = "eDP-1, 1920x1080, 0x0, 1";

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
	"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
	"col.inactive_border" = "rgba(595959aa)";

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

	drop_shadow = "yes";
	shadow_range = 4;
	shadow_render_power = 3;
	"col.shadow" = "rgba(1a1a1aee)";
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
	new_is_master = true;
      };

      gestures = {
	workspace_swipe = "off";
      };

      misc = {
	force_default_wallpaper = "-1";
      };

      "$mainMod" = "SUPER";

      bind = [
	"$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, dolphin"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, wofi --show drun"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
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
	"$mainMod, S, togglespecialworkspace, magic"
	"$mainMod SHIFT, S, movetoworkspace, special:magic"
	"$mainMod, mouse_down, workspace, e+1"
	"$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
	"$mainMod, mouse:272, movewindow"
	"$mainMod, mouse:273, resizewindow"
      ];
      
      exec-once = "swww init";
    };

    extraConfig = ''
      device:epic-mouse-v1 {
	sensitivity = -0.5
      }
    '';
  };
}
