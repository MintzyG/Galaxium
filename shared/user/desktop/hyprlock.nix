{ lib, ... }:
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = lib.mkForce [
        {
          monitor = "";
          path = "";
          reload_time = 0;
          reload_cmd = ''ls $HOME/.config/galaxium/assets/wallpapers | shuf -n1 | xargs -I{} echo "$HOME/.config/galaxium/assets/wallpapers/{}"'';
          blur_passes = 3;
          blur_size = 7;
          brightness = 0.5;
        }
      ];


      label = lib.mkForce [
        {
          monitor = "";
          text = "$TIME";
          font_size = 96;
          font_family = "JetBrains Mono Bold";
          color = "rgba(255, 255, 255, 0.9)";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] date "+%A, %d %B"'';
          font_size = 24;
          font_family = "JetBrains Mono";
          color = "rgba(255, 255, 255, 0.7)";
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
      ];

      "input-field" = lib.mkForce [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 2;
          dots_size = 0.3;
          dots_spacing = 0.2;
          outer_color = "rgba(255, 255, 255, 0.3)";
          inner_color = "rgba(0, 0, 0, 0.5)";
          font_color = "rgba(255, 255, 255, 0.9)";
          fade_on_empty = true;
          placeholder_text = "";
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
