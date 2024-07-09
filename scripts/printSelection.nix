{ pkgs, ... }:

pkgs.writeShellScriptBin "printSelection" ''
  ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d -w 0)" - | ${pkgs.swappy}/bin/swappy -f -
''
