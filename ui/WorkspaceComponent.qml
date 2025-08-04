import Quickshell
import Quickshell.Hyprland
import QtQuick

Column {
  anchors.horizontalCenter: parent.horizontalCenter
  spacing: 6
  y: 6

  Repeater {
    model: Hyprland.workspaces

    delegate: Item {
      width: textItem.paintedWidth + 10
      height: textItem.paintedHeight

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Hyprland.dispatch("workspace " + modelData.id)
      }

      Rectangle {
        width: parent.width
        height: parent.height
        radius: width / 2
        color: modelData.id === Hyprland.focusedWorkspace.id ? "black" : "white"
        border.color: modelData.id === Hyprland.focusedWorkspace.id ? "gray" : "black"

        Text {
          id: textItem
          text: modelData.name
          anchors.horizontalCenter: parent.horizontalCenter
          color: modelData.id === Hyprland.focusedWorkspace.id ? "white" : "black"
        }
      }
    }
  }
}
