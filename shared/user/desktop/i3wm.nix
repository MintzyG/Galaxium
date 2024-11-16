{ pkgs, lib, ... }:
let
  mod = "Mod4";
in
{

  imports = [
    ../services/polybar.nix
  ];

  home.packages = with pkgs; [
    xclip
    maim
    feh
  ];

  xsession.windowManager.i3 = {
    enable = true;

    extraConfig = ''
      font pango:JetBrains Mono 0
      #for_window [class=".*"] title_format "<span alpha='1'>%title</span>"
    '';

    config = {
      modifier = "${mod}";

      terminal = "kitty";

      defaultWorkspace = "workspace number 1";

      gaps = {
        inner = 10;
        outer = 5;
      };

      window = {
        titlebar = false;
        border = 0;
      };

      fonts = {
        names = [ "JetBrains Mono" ];
        size = 8.0;
      };

      bars = [
        # {
        #   position = "top";
        #   mode = "dock";
        #   fonts = {
        #     names = [ "JetBrains Mono" ];
        #     size = 11.0;
        #   };
        #   colors = {
        #     background = "#181c24";
        #     focusedWorkspace = {
        #       background = "#afafaf";
        #       border = "#afafaf";
        #       text = "#181c24";
        #     };
        #     inactiveWorkspace = {
        #       background = "#181c24";
        #       border = "#afafaf";
        #       text = "#afafaf";
        #     };
        #   };
        #   extraConfig = ''separator_symbol " / "'';
        # }
      ];

      keybindings = lib.mkOptionDefault {
        "${mod}+r" = "exec --no-startup-id rofi -show drun -show-icons";
        "${mod}+q" = "exec kitty";
        "${mod}+c" = "kill";

        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        "${mod}+h" = "split h";
        "${mod}+v" = "split v";

        "${mod}+f" = "fullscreen toggle";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";

      
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        "${mod}+Shift+1" = "move container workspace number 1";
        "${mod}+Shift+2" = "move container workspace number 2";
        "${mod}+Shift+3" = "move container workspace number 3";
        "${mod}+Shift+4" = "move container workspace number 4";
        "${mod}+Shift+5" = "move container workspace number 5";
        "${mod}+Shift+6" = "move container workspace number 6";
        "${mod}+Shift+7" = "move container workspace number 7";
        "${mod}+Shift+8" = "move container workspace number 8";
        "${mod}+Shift+9" = "move container workspace number 9";
        "${mod}+Shift+0" = "move container workspace number 10";
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";

        "Ctrl+Print" = "exec --no-startup-id maim \"/home/sophia/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png\"";
        "Ctrl+${mod}+Shift+Print" = "exec --no-startup-id maim -o --select \"/home/sophia/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png\"";

        "Print" = "exec --no-startup-id maim | xclip -selection clipboard -t image/png";
        "Shift+Print" = "exec --no-startup-id maim -o --select | xclip -selection clipboard -t image/png";
      };

      startup = [
        { command = "systemctl --user restart polybar"; always = true; notification = false; }
        { command = "picom --config ~/.config/picom/picom.conf"; always = true; notification = false; }
        { command = "feh --bg-fill --randomize ~/.config/galaxium/assets/wallpapers/*"; always = true; notification = false; }
      ];
    };
  };
}
