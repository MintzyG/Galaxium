{ pkgs, ... }:

pkgs.writeShellScriptBin "print" ''
  ${pkgs.grim}/bin/grim - | ${pkgs.swappy}/bin/swappy -f -
''
