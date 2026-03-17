import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

Scope {
    id: root

    required property var screen

    NotificationServer {
        id: server
        imageSupported: true
        onNotification: notif => {
            console.log("appName:", notif.appName, "| appIcon:", notif.appIcon, "| desktopEntry:", notif.desktopEntry, "| image:", notif.image, "| summary:", notif.summary, "| urgency:", notif.urgency, "| expireTimeout:", notif.expireTimeout, "| hints:", JSON.stringify(notif.hints))
            if (notifModel.count >= 5) {
                notifModel.setProperty(notifModel.count - 1, "forceDismiss", true)
            }
            notifModel.insert(0, { "notif": notif, "forceDismiss": false })
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

        Process {
            id: focusApp
            property string appClass: ""
            command: ["hyprctl", "dispatch", "focuswindow", "class:^(" + (appClass ?? "") + ")$"]
            onRunningChanged: console.log("focusApp running:", running, "| appClass:", appClass)
        }

        Repeater {
            model: notifModel

            delegate: Item {
                required property int index
                required property var notif
                required property bool forceDismiss

                width: 300
                height: 80
                x: 56

                property bool entered: false
                property bool dismissed: false
                property real elapsed: 0
                property real totalDuration: 5000

                readonly property bool hasProfilePic: notif.image !== ""
                readonly property string resolvedIcon: notif.appIcon !== "" ? notif.appIcon : notif.desktopEntry
                readonly property string notifDesktopEntry: notif.desktopEntry ?? ""
                readonly property string notifAppName: notif.appName ?? ""
                readonly property string notifSummary: notif.summary ?? ""
                readonly property string notifBody: notif.body ?? ""
                readonly property string notifImage: notif.image ?? ""
                readonly property string notifAppIcon: notif.appIcon ?? ""

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

                onForceDismissChanged: {
                    if (forceDismiss) dismiss()
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

                TapHandler {
                    id: pillTap
                    onTapped: {
                        console.log("pill tapped | desktopEntry:", notifDesktopEntry)
                        focusApp.appClass = notifDesktopEntry
                        focusApp.running = false
                        focusApp.running = true
                        dismiss()
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
                    id: contentArea
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                        right: parent.right
                        leftMargin: 40
                        topMargin: 6
                        bottomMargin: 6
                        rightMargin: 6
                    }
                    radius: 8
                    color: "#ede6cf"

                    Column {
                        anchors {
                            fill: parent
                            margins: 8
                        }
                        spacing: 2
                        clip: true

                        Text {
                            width: parent.width
                            text: notifSummary
                            font.pixelSize: 12
                            font.bold: true
                            color: "#2e383c"
                            elide: Text.ElideRight
                        }

                        Text {
                            width: parent.width
                            text: notifBody
                            font.pixelSize: 11
                            color: "#4a5568"
                            elide: Text.ElideRight
                            maximumLineCount: 2
                            wrapMode: Text.WordWrap
                        }
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
                        id: profilePic
                        anchors.centerIn: parent
                        width: parent.width * 0.75
                        height: width
                        source: hasProfilePic ? notifImage : ""
                        visible: !itemHover.hovered && hasProfilePic && status === Image.Ready
                        fillMode: Image.PreserveAspectCrop
                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: Rectangle {
                                width: profilePic.width
                                height: profilePic.height
                                radius: width / 2
                                visible: false
                            }
                        }
                    }

                    Image {
                        id: appIcon
                        anchors.centerIn: parent
                        width: parent.width * 0.5
                        height: width
                        source: !hasProfilePic && resolvedIcon !== "" ? "image://icon/" + resolvedIcon : ""
                        visible: !itemHover.hovered && !hasProfilePic && status === Image.Ready
                    }

                    Text {
                        anchors.centerIn: parent
                        text: notifAppName !== "" ? notifAppName.charAt(0).toUpperCase() : "?"
                        font.pixelSize: 28
                        font.bold: true
                        color: "#2e383c"
                        visible: !itemHover.hovered && !hasProfilePic && !appIcon.visible
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
                            grabPermissions: TapHandler.CanTakeOverFromAnything
                            onTapped: {
                                console.log("dismiss tapped")
                                dismiss()
                            }
                        }
                    }
                }
            }
        }
    }
}
