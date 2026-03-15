import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick

ShellRoot {
    id: root

    property real brightness: 0.5
    property real brightnessMax: 1.0
    property bool volumeChanged: false
    property bool brightnessChanged: false

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
    }

    Connections {
        target: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio : null
        function onVolumeChanged() {
            root.volumeChanged = true
            autoHideTimer.restart()
        }
        function onMutedChanged() {
            root.volumeChanged = true
            autoHideTimer.restart()
        }
    }

    Timer {
        id: autoHideTimer
        interval: 1000
        onTriggered: {
            root.volumeChanged = false
            root.brightnessChanged = false
        }
    }

    Process {
        id: procMax
        command: ["brightnessctl", "max"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                if (data.trim()) root.brightnessMax = parseInt(data) || 1
            }
        }
        onRunningChanged: {
            if (!running) pollTimer.start()
        }
    }

    Process {
        id: procGet
        command: ["brightnessctl", "get"]
        stdout: SplitParser {
            onRead: data => {
                if (data.trim()) {
                    var newVal = parseInt(data) / root.brightnessMax
                    if (Math.abs(newVal - root.brightness) > 0.005) {
                        root.brightnessChanged = true
                        autoHideTimer.restart()
                    }
                    root.brightness = newVal
                }
            }
        }
        onRunningChanged: {
            if (!running) pollTimer.scheduleRestart()
        }
    }

    Process {
        id: procSetBrightness
        property real targetRatio: 0.5
        command: ["brightnessctl", "set", String(Math.round(targetRatio * root.brightnessMax))]
        onRunningChanged: {
            if (!running) procGet.running = true
        }
    }

    Process {
        id: procSetVolume
        property real targetVolume: 0.5
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", String(Math.min(targetVolume, 1.5).toFixed(2))]
    }

    Timer {
        id: pollTimer
        interval: 100
        function scheduleRestart() { restart() }
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
            property bool shouldShow: hovered || root.volumeChanged || root.brightnessChanged
            property real barHeight: screen.height / 2
            property real cornerSize: 30
            property real bodyRadius: 30
            property string bgColor: "#f3ead3"
            property real volume: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio.volume : 0.5
            property bool muted: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio.muted : false
            property real volumeClamped: Math.min(panel.volume, 1.0)
            property bool volumeOver: panel.volume > 1.0
            property real overRatio: Math.min((panel.volume - 1.0) / 0.5, 1.0)

            // faixa invisível sempre presente na borda
            Item {
                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
                width: 4

                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            panel.hovered = true
                            autoHideTimer.stop()
                        } else if (!containerHover.hovered) {
                            panel.hovered = false
                        }
                    }
                }
            }

            Item {
                id: container
                width: 60
                height: panel.barHeight + panel.cornerSize * 2
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                }

                opacity: panel.shouldShow ? 1.0 : 0.0
                Behavior on opacity {
                    NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                }
                transform: Translate {
                    x: panel.shouldShow ? 0 : 60
                    Behavior on x {
                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }
                }

                HoverHandler {
                    id: containerHover
                    onHoveredChanged: {
                        if (hovered) {
                            panel.hovered = true
                            autoHideTimer.stop()
                        } else {
                            panel.hovered = false
                        }
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
                            id: volPill
                            width: parent.width
                            height: (parent.height - 10) / 2
                            radius: width / 2
                            color: "#e5dfc5"
                            clip: true

                            WheelHandler {
                                onWheel: event => {
                                    var delta = event.angleDelta.y / 1200.0
                                    var newVol = Math.max(0.0, Math.min(1.5, panel.volume + delta))
                                    procSetVolume.targetVolume = newVol
                                    procSetVolume.running = true
                                    root.volumeChanged = true
                                    autoHideTimer.restart()
                                }
                            }

                            DragHandler {
                                target: null
                                onTranslationChanged: {
                                    var ratio = 1.0 - (centroid.position.y / volPill.height)
                                    ratio = Math.max(0.0, Math.min(1.5, ratio))
                                    procSetVolume.targetVolume = ratio
                                    procSetVolume.running = true
                                    root.volumeChanged = true
                                    autoHideTimer.restart()
                                }
                            }

                            Rectangle {
                                anchors {
                                    bottom: parent.bottom
                                    horizontalCenter: parent.horizontalCenter
                                    bottomMargin: 3
                                }
                                width: parent.width - 6
                                height: (parent.height - 6) * panel.volumeClamped
                                radius: width / 2
                                color: panel.muted ? "#f85552" : "#2e383c"

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
                                    color: Qt.rgba(1, 1 - panel.overRatio * 0.8, 1 - panel.overRatio * 0.8, 1)
                                    visible: parent.height > height + 6

                                    Behavior on color {
                                        ColorAnimation { duration: 80 }
                                    }

                                    Text {
                                        anchors.centerIn: parent
                                        text: panel.muted ? "󰖁" : "󰕾"
                                        font.pixelSize: parent.width * 0.5
                                        font.family: "JetBrainsMono Nerd Font Mono"
                                        color: "#2e383c"
                                    }
                                }
                            }
                        }

                        // Brilho pill
                        Rectangle {
                            id: briPill
                            width: parent.width
                            height: (parent.height - 10) / 2
                            radius: width / 2
                            color: "#e5dfc5"
                            clip: true

                            WheelHandler {
                                onWheel: event => {
                                    var delta = event.angleDelta.y / 1200.0
                                    var newBri = Math.max(0.0, Math.min(1.0, root.brightness + delta))
                                    procSetBrightness.targetRatio = newBri
                                    procSetBrightness.running = true
                                    root.brightnessChanged = true
                                    autoHideTimer.restart()
                                }
                            }

                            DragHandler {
                                target: null
                                onTranslationChanged: {
                                    var ratio = 1.0 - (centroid.position.y / briPill.height)
                                    ratio = Math.max(0.0, Math.min(1.0, ratio))
                                    procSetBrightness.targetRatio = ratio
                                    procSetBrightness.running = true
                                    root.brightnessChanged = true
                                    autoHideTimer.restart()
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
    }
}
