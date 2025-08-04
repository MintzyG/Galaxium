import Quickshell
import QtQuick

PanelWindow {
  id: root

  width: bg.width
  height: bg.height
  color: "transparent"

  anchors.top: true
  Rectangle {
    id: bg
    color: "white"
    radius: 8
    border.color: "gray"
    border.width: 1

    width: childrenRect.width + 16
    height: childrenRect.height + 12

    ClockWidget {
      anchors.centerIn: parent
      font.pixelSize: 14
      color: "black"
      padding: 6
    }
  }
}

