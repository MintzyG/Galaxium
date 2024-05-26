#!/usr/bin/env bash

Wallpaper=$(ls -1 ~/galaxium/assets/wallpapers/*.png | shuf | head -1)
swww img "$Wallpaper" --transition-step 90 --transition-type outer --transition-pos 1.1,0.5
