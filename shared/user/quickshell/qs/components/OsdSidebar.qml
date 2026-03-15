import QtQuick

Item {
    id: root

    required property real brightness
    required property real volume
    required property bool muted
    required property bool volumeChanged
    required property bool brightnessChanged

    signal setVolume(real value)
    signal setBrightness(real value)
    signal stopAutoHide()

    property bool hovered: false
    property bool shouldShow: hovered || volumeChanged || brightnessChanged
    property real barHeight: parent.height / 2
    property real cornerSize: 30
    property real bodyRadius: 30
    property string bgColor: "#f3ead3"
    property real volumeClamped: Math.min(volume, 1.0)
    property real overRatio: Math.min((volume - 1.0) / 0.5, 1.0)

    implicitWidth: 60

    Item {
        id: container
        width: 60
        height: root.barHeight + root.cornerSize * 2
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
        }

        opacity: root.shouldShow ? 1.0 : 0.0
        Behavior on opacity {
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
        }
        transform: Translate {
            x: root.shouldShow ? 0 : 60
            Behavior on x {
                NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
            }
        }

        Canvas {
            width: root.cornerSize
            height: root.cornerSize
            anchors { top: parent.top; right: parent.right }
            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.fillStyle = root.bgColor
                ctx.beginPath()
                ctx.moveTo(width, height)
                ctx.lineTo(width, 0)
                ctx.lineTo(0, 0)
                ctx.arc(0, 0, width, 0, Math.PI / 2, false)
                ctx.fill()
            }
        }

        Canvas {
            width: root.cornerSize
            height: root.cornerSize
            anchors { bottom: parent.bottom; right: parent.right }
            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.fillStyle = root.bgColor
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
                topMargin: root.cornerSize
                bottomMargin: root.cornerSize
            }
            width: 60
            color: root.bgColor
            radius: root.bodyRadius

            Rectangle {
                anchors { top: parent.top; bottom: parent.bottom; right: parent.right }
                width: root.bodyRadius
                color: root.bgColor
            }

            Column {
                anchors { fill: parent; margins: 10 }
                spacing: 10

                Rectangle {
                    id: volPill
                    width: parent.width
                    height: (parent.height - 10) / 2
                    radius: width / 2
                    color: "#e5dfc5"
                    clip: true

                    WheelHandler {
                        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                        onWheel: event => {
                            var delta = event.angleDelta.y / 1200.0
                            root.setVolume(Math.max(0.0, Math.min(1.5, root.volume + delta)))
                        }
                    }

                    DragHandler {
                        target: null
                        onTranslationChanged: {
                            var ratio = 1.0 - (centroid.position.y / volPill.height)
                            root.setVolume(Math.max(0.0, Math.min(1.5, ratio)))
                        }
                    }

                    Rectangle {
                        anchors {
                            bottom: parent.bottom
                            horizontalCenter: parent.horizontalCenter
                            bottomMargin: 3
                        }
                        width: parent.width - 6
                        height: (parent.height - 6) * root.volumeClamped
                        radius: width / 2
                        color: root.muted ? "#f85552" : "#2e383c"

                        Behavior on height {
                            NumberAnimation { duration: 80; easing.type: Easing.OutCubic }
                        }
                        Behavior on color {
                            ColorAnimation { duration: 100 }
                        }

                        Rectangle {
                            anchors {
                                top: parent.top
                                horizontalCenter: parent.horizontalCenter
                                topMargin: 3
                            }
                            width: parent.width - 6
                            height: width
                            radius: width / 2
                            color: Qt.rgba(1, 1 - root.overRatio * 0.8, 1 - root.overRatio * 0.8, 1)
                            visible: parent.height > height + 6

                            Behavior on color {
                                ColorAnimation { duration: 80 }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: root.muted ? "󰖁" : "󰕾"
                                font.pixelSize: parent.width * 0.5
                                font.family: "JetBrainsMono Nerd Font Mono"
                                color: "#2e383c"
                            }
                        }
                    }
                }

                Rectangle {
                    id: briPill
                    width: parent.width
                    height: (parent.height - 10) / 2
                    radius: width / 2
                    color: "#e5dfc5"
                    clip: true

                    WheelHandler {
                        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                        onWheel: event => {
                            var delta = event.angleDelta.y / 1200.0
                            root.setBrightness(Math.max(0.0, Math.min(1.0, root.brightness + delta)))
                        }
                    }

                    DragHandler {
                        target: null
                        onTranslationChanged: {
                            var ratio = 1.0 - (centroid.position.y / briPill.height)
                            root.setBrightness(Math.max(0.0, Math.min(1.0, ratio)))
                        }
                    }

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
                                topMargin: 3
                            }
                            width: parent.width - 6
                            height: width
                            radius: width / 2
                            color: "white"
                            visible: parent.height > height + 6

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
