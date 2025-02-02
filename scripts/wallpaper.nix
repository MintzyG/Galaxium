{ pkgs, ... }:

pkgs.writeShellScriptBin "Wallpaper" ''
  Wallpaper=$(ls -1 ~/.config/galaxium/assets/wallpapers/* | shuf | head -1)
  X_POS=$(awk -v min=-0.1 -v max=1.1 'BEGIN{srand(); print min+rand()*(max-min)}')
  Y_POS=$(awk -v min=-0.1 -v max=1.1 'BEGIN{srand(); print min+rand()*(max-min)}')
  ${pkgs.swww}/bin/swww img "$Wallpaper" --transition-step 90 --transition-type outer --transition-pos "$X_POS,$Y_POS"
''
