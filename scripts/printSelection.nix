{ pkgs, ... }:
pkgs.writeShellScriptBin "printSelection" ''
  TMPFILE=$(mktemp /tmp/screenshot-XXXXXX.png)
  ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d -w 0)" - | ${pkgs.swappy}/bin/swappy -f - -o "$TMPFILE"
  if [ -f "$TMPFILE" ]; then
    ${pkgs.wl-clipboard}/bin/wl-copy < "$TMPFILE"
    rm "$TMPFILE"
  fi
''
