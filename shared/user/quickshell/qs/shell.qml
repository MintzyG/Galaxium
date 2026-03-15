import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick

ShellRoot {
    id: root

    property real brightness: 0.5
    property real brightnessMax: 1.0

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
    }

    Process {
        id: procMax
        command: ["brightnessctl", "max"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                if (data) {
                    root.brightnessMax = parseInt(data) || 1
                    procGet.running = true
                }
            }
        }
    }

    Process {
        id: procGet
        command: ["brightnessctl", "get"]
        stdout: SplitParser {
            onRead: data => {
                if (data) root.brightness = parseInt(data) / root.brightnessMax
            }
        }
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: procGet.running = true
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel
            required property var modelData
            screen: modelData

            anchors {
                right: true
                top: true
                bottom: true
            }

            implicitWidth: 60
            color: "transparent"
            exclusiveZone: -1

            property bool hovered: false
            property real barHeight: screen.height / 2
            property real cornerSize: 30
            property real bodyRadius: 30
            property string bgColor: "#f3ead3"
            property real volume: Pipewire.defaultAudioSink?.audio?.volume ?? 0.5

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: panel.hovered = true
                onExited: panel.hovered = false
            }

            Item {
                width: 60
                height: panel.barHeight + panel.cornerSize * 2
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                }

                opacity: panel.hovered ? 1.0 : 0.0
                Behavior on opacity {
                    NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                }
                transform: Translate {
                    x: panel.hovered ? 0 : 60
                    Behavior on x {
                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }
                }

                Canvas {
                    width: panel.cornerSize
                    height: panel.cornerSize
                    anchors { top: parent.top; right: parent.right }
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.fillStyle = panel.bgColor
                        ctx.beginPath()
                        ctx.moveTo(width, height)
                        ctx.lineTo(width, 0)
                        ctx.lineTo(0, 0)
                        ctx.arc(0, 0, width, 0, Math.PI / 2, false)
                        ctx.fill()
                    }
                }

                Canvas {
                    width: panel.cornerSize
                    height: panel.cornerSize
                    anchors { bottom: parent.bottom; right: parent.right }
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.fillStyle = panel.bgColor
                        ctx.beginPath()
                        ctx.moveTo(width, 0)
                        ctx.lineTo(width, height)
                        ctx.lineTo(0, height)
                        ctx.arc(0, height, width, 0, -Math.PI / 2, true)
                        ctx.fill()
                    }
                }

                Rectangle {
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        right: parent.right
                        topMargin: panel.cornerSize
                        bottomMargin: panel.cornerSize
                    }
                    width: 60
                    color: panel.bgColor
                    radius: panel.bodyRadius

                    Rectangle {
                        anchors { top: parent.top; bottom: parent.bottom; right: parent.right }
                        width: panel.bodyRadius
                        color: panel.bgColor
                    }

                    Column {
                        anchors { fill: parent; margins: 10 }
                        spacing: 10

                        // Volume pill
                        Rectangle {
                            width: parent.width
                            height: (parent.height - 10) / 2
                            radius: width / 2
                            color: "#e5dfc5"
                            clip: true

                            Rectangle {
                                anchors {
                                    bottom: parent.bottom
                                    horizontalCenter: parent.horizontalCenter
                                    bottomMargin: 3
                                }
                                width: parent.width - 6
                                height: (parent.height - 6) * panel.volume
                                radius: width / 2
                                color: "#2e383c"

                                Behavior on height {
                                    NumberAnimation { duration: 80; easing.type: Easing.OutCubic }
                                }

                                Rectangle {
                                    anchors {
                                        top: parent.top
                                        horizontalCenter: parent.horizontalCenter
                                        topMargin: 4
                                    }
                                    width: parent.width - 6
                                    height: width
                                    radius: width / 2
                                    color: "white"
                                    visible: parent.height > height + 8

                                    Text {
                                        anchors.centerIn: parent
                                        text: "󰕾"
                                        font.pixelSize: parent.width * 0.5
                                        font.family: "JetBrainsMono Nerd Font Mono"
                                        color: "#2e383c"
                                    }
                                }
                            }
                        }

                        // Brilho pill
                        Rectangle {
                            width: parent.width
                            height: (parent.height - 10) / 2
                            radius: width / 2
                            color: "#e5dfc5"
                            clip: true

                            Rectangle {
                                anchors {
                                    bottom: parent.bottom
                                    horizontalCenter: parent.horizontalCenter
                                    bottomMargin: 3
                                }
                                width: parent.width - 6
                                height: (parent.height - 6) * root.brightness
                                radius: width / 2
                                color: "#2e383c"

                                Behavior on height {
                                    NumberAnimation { duration: 80; easing.type: Easing.OutCubic }
                                }

                                Rectangle {
                                    anchors {
                                        top: parent.top
                                        horizontalCenter: parent.horizontalCenter
                                        topMargin: 4
                                    }
                                    width: parent.width - 6
                                    height: width
                                    radius: width / 2
                                    color: "white"
                                    visible: parent.height > height + 8

                                    Text {
                                        anchors.centerIn: parent
                                        text: "󰃞"
                                        font.pixelSize: parent.width * 0.5
                                        font.family: "JetBrainsMono Nerd Font Mono"
                                        color: "#2e383c"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
