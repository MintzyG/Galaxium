import Quickshell
import Quickshell.Wayland
import QtQuick

ShellRoot {
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

                // canto côncavo superior
                Canvas {
                    width: panel.cornerSize
                    height: panel.cornerSize
                    anchors {
                        top: parent.top
                        right: parent.right
                    }
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

                // canto côncavo inferior
                Canvas {
                    width: panel.cornerSize
                    height: panel.cornerSize
                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                    }
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

                // corpo principal
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

                    // tapa o radius direito
                    Rectangle {
                        anchors {
                            top: parent.top
                            bottom: parent.bottom
                            right: parent.right
                        }
                        width: panel.bodyRadius
                        color: panel.bgColor
                    }

                    Column {
                        anchors {
                            fill: parent
                            margins: 10
                        }
                        spacing: 10

                        // Volume
                        Rectangle {
                            width: parent.width
                            height: (parent.height - 10) / 2
                            radius: width / 2
                            color: "#e5dfc5"

                            // cabeça
                            Rectangle {
                                anchors {
                                    top: parent.top
                                    horizontalCenter: parent.horizontalCenter
                                    topMargin: -width / 2
                                }
                                width: parent.width
                                height: parent.width
                                radius: width / 2
                                color: "white"

                                Text {
                                    anchors.centerIn: parent
                                    text: "󰕾"
                                    font.pixelSize: parent.width * 0.5
                                    font.family: "JetBrainsMono Nerd Font Mono"
                                    color: "#2e383c"
                                }
                            }

                            // barra interna
                            Rectangle {
                                anchors {
                                    bottom: parent.bottom
                                    horizontalCenter: parent.horizontalCenter
                                    bottomMargin: 3
                                }
                                width: parent.width - 6
                                height: (parent.height - 6) * 0.7
                                radius: width / 2
                                color: "#2e383c"

                                Behavior on height {
                                    NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
                                }
                            }
                        }

                        // Brilho
                        Rectangle {
                            width: parent.width
                            height: (parent.height - 10) / 2
                            radius: width / 2
                            color: "#e5dfc5"

                            // cabeça
                            Rectangle {
                                anchors {
                                    top: parent.top
                                    horizontalCenter: parent.horizontalCenter
                                    topMargin: -width / 2
                                }
                                width: parent.width
                                height: parent.width
                                radius: width / 2
                                color: "white"

                                Text {
                                    anchors.centerIn: parent
                                    text: "󰃞"
                                    font.pixelSize: parent.width * 0.5
                                    font.family: "JetBrainsMono Nerd Font Mono"
                                    color: "#2e383c"
                                }
                            }

                            // barra interna
                            Rectangle {
                                anchors {
                                    bottom: parent.bottom
                                    horizontalCenter: parent.horizontalCenter
                                    bottomMargin: 3
                                }
                                width: parent.width - 6
                                height: (parent.height - 6) * 0.5
                                radius: width / 2
                                color: "#2e383c"

                                Behavior on height {
                                    NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
