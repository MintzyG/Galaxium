{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zig
    gtk3
    webkitgtk_4_1
  ];
}
