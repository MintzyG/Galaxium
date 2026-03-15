{ pkgs, ... }:
pkgs.writeShellScriptBin "print" ''
  TMPFILE=$(mktemp /tmp/screenshot-XXXXXX.png)
  ${pkgs.grim}/bin/grim - | ${pkgs.swappy}/bin/swappy -f - -o "$TMPFILE"
  if [ -f "$TMPFILE" ]; then
    ${pkgs.wl-clipboard}/bin/wl-copy < "$TMPFILE"
    rm "$TMPFILE"
  fi
''
