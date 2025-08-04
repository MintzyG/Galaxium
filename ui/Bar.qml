import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Hyprland

Scope {
  Variants {
    model: Quickshell.screens;

    PanelWindow {
      property var modelData
      screen: modelData

      anchors {
        top: true
        bottom: true
        left: true
      }

      implicitWidth: 30

      WorkspaceComponent{}
    }
  }
}
