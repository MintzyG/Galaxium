{ pkgs, ... }:

pkgs.writeShellScriptBin "Wallpaper" ''
  Wallpaper=$(ls -1 ~/.config/galaxium/assets/wallpapers/*.png | shuf | head -1)
  ${pkgs.swww}/bin/swww img "$Wallpaper" --transition-step 90 --transition-type outer --transition-pos 1.1,0.5
''
