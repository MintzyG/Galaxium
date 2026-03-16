import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Scope {
    id: root

    required property var screen

    NotificationServer {
        id: server
        onNotification: notif => {
            notifModel.insert(0, { "notif": notif })
        }
    }

    ListModel {
        id: notifModel
    }

    PanelWindow {
        id: notifWindow
        screen: root.screen
        anchors { top: true; right: true }
        implicitWidth: 372
        implicitHeight: 600
        color: "transparent"
        exclusiveZone: -1

        mask: Region {
            x: 56
            y: 16
            width: 316
            height: notifModel.count > 0 ? notifModel.count * 96 - 16 : 0
        }

        property int hoveredCount: 0
        property bool anyHovered: hoveredCount > 0

        Repeater {
            model: notifModel

            delegate: Item {
                required property int index
                required property var notif

                width: 300
                height: 80
                x: 56

                property bool entered: false
                property bool dismissed: false
                property real elapsed: 0
                property real totalDuration: 5000

                y: entered ? 16 + index * 96 : -(80 + 16)

                Behavior on y {
                    NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
                }

                transform: Translate {
                    id: slideOut
                    x: 0
                    Behavior on x {
                        NumberAnimation { duration: 250; easing.type: Easing.InCubic }
                    }
                }

                function dismiss() {
                    if (dismissed) return
                    dismissed = true
                    tickTimer.stop()
                    dismissTimer.stop()
                    slideOut.x = 400
                }

                onDismissedChanged: {
                    if (dismissed) removeTimer.start()
                }

                // tick a cada 100ms pra acumular elapsed
                Timer {
                    id: tickTimer
                    interval: 100
                    repeat: true
                    running: entered && !dismissed && !notifWindow.anyHovered
                    onTriggered: {
                        elapsed += 100
                        if (elapsed >= totalDuration) dismiss()
                    }
                }

                // quando o hover solta, reinicia o dismissTimer com o tempo restante
                Connections {
                    target: notifWindow
                    function onAnyHoveredChanged() {
                        if (!notifWindow.anyHovered && !dismissed && entered) {
                            dismissTimer.interval = Math.max(0, totalDuration - elapsed)
                            dismissTimer.restart()
                        } else {
                            dismissTimer.stop()
                        }
                    }
                }

                Timer {
                    id: enterTimer
                    interval: 16
                    running: true
                    onTriggered: {
                        entered = true
                        dismissTimer.interval = totalDuration
                        dismissTimer.start()
                    }
                }

                Timer {
                    id: dismissTimer
                    onTriggered: dismiss()
                }

                Timer {
                    id: removeTimer
                    interval: 260
                    onTriggered: notifModel.remove(index)
                }

                HoverHandler {
                    id: itemHover
                    onHoveredChanged: {
                        notifWindow.hoveredCount += hovered ? 1 : -1
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    radius: 12
                    color: "#f3ead3"

                    Rectangle {
                        anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
                        width: parent.radius
                        color: "#f3ead3"
                    }
                }

                Rectangle {
                    id: iconCircle
                    width: height
                    height: parent.height
                    radius: height / 2
                    color: "#f3ead3"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: -(height / 2)

                    Image {
                        id: appIcon
                        anchors.centerIn: parent
                        width: parent.width * 0.5
                        height: width
                        source: notif.appIcon ? "image://icon/" + notif.appIcon : ""
                        visible: !itemHover.hovered && status === Image.Ready
                    }

                    Text {
                        anchors.centerIn: parent
                        text: notif.appName ? notif.appName.charAt(0).toUpperCase() : "?"
                        font.pixelSize: 28
                        font.bold: true
                        color: "#2e383c"
                        visible: !itemHover.hovered && !appIcon.visible
                    }

                    Rectangle {
                        id: dismissBtn
                        anchors.centerIn: parent
                        width: parent.width - 16
                        height: width
                        radius: width / 2
                        color: "#f85552"
                        opacity: itemHover.hovered ? 1.0 : 0.0
                        scale: itemHover.hovered ? 1.0 : 0.0

                        Behavior on scale {
                            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
                        }
                        Behavior on opacity {
                            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
                        }

                        Text {
                            anchors.centerIn: parent
                            text: "✕"
                            font.pixelSize: parent.width * 0.4
                            color: "white"
                        }

                        TapHandler {
                            onTapped: dismiss()
                        }
                    }
                }
            }
        }
    }
}
