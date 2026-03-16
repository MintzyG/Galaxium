pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick
import "./components"

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

        Scope {
            id: scope
            required property var modelData

            PanelWindow {
                screen: scope.modelData
                anchors.top: true
                exclusiveZone: 10
                implicitHeight: 1
                implicitWidth: 1
                color: "transparent"
                mask: Region {}
            }
            PanelWindow {
                screen: scope.modelData
                anchors.bottom: true
                exclusiveZone: 10
                implicitHeight: 1
                implicitWidth: 1
                color: "transparent"
                mask: Region {}
            }
            PanelWindow {
                screen: scope.modelData
                anchors.left: true
                exclusiveZone: 10
                implicitHeight: 1
                implicitWidth: 1
                color: "transparent"
                mask: Region {}
            }
            PanelWindow {
                screen: scope.modelData
                anchors.right: true
                exclusiveZone: 10
                implicitHeight: 1
                implicitWidth: 1
                color: "transparent"
                mask: Region {}
            }

            PanelWindow {
                id: win
                screen: scope.modelData

                anchors {
                    top: true
                    bottom: true
                    left: true
                    right: true
                }

                exclusiveZone: -1
                color: "transparent"

                property int edge: 10

                mask: Region {
                    x: win.edge
                    y: win.edge
                    width: win.width - win.edge * 2
                    height: win.height - win.edge * 2
                    intersection: Intersection.Xor

                    regions: [
                        Region {
                            x: win.width - win.edge - 60
                            y: (win.height - sidebar.barHeight - sidebar.cornerSize * 2) / 2
                            width: sidebar.shouldShow ? 60 : win.edge
                            height: sidebar.barHeight + sidebar.cornerSize * 2
                            intersection: Intersection.Subtract
                        }
                    ]
                }

                ScreenEdge {
                    anchors.fill: parent
                    edgeSize: win.edge
                }

                Item {
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }
                    width: win.edge
                    height: sidebar.barHeight + sidebar.cornerSize * 2

                    HoverHandler {
                        id: edgeHover
                        onHoveredChanged: {
                            if (hovered) {
                                sidebar.hovered = true
                                autoHideTimer.stop()
                            }
                        }
                    }
                }

                Item {
                    anchors {
                        fill: parent
                        margins: win.edge
                    }

                    Item {
                        anchors {
                            right: parent.right
                            top: parent.top
                            bottom: parent.bottom
                        }
                        width: 60

                        HoverHandler {
                            id: osdHover
                            onHoveredChanged: {
                                if (!hovered && !edgeHover.hovered) {
                                    sidebar.hovered = false
                                    if (!root.volumeChanged && !root.brightnessChanged) autoHideTimer.restart()
                                }
                            }
                        }
                    }

                    OsdSidebar {
                        id: sidebar
                        anchors {
                            right: parent.right
                            top: parent.top
                            bottom: parent.bottom
                        }

                        brightness: root.brightness
                        brightnessChanged: root.brightnessChanged
                        volume: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio.volume : 0.5
                        muted: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio.muted : false
                        volumeChanged: root.volumeChanged

                        onSetVolume: v => {
                            procSetVolume.targetVolume = v
                            procSetVolume.running = true
                            root.volumeChanged = true
                            autoHideTimer.restart()
                        }
                        onSetBrightness: v => {
                            procSetBrightness.targetRatio = v
                            procSetBrightness.running = true
                            root.brightnessChanged = true
                            autoHideTimer.restart()
                        }
                        onStopAutoHide: autoHideTimer.stop()
                    }
                }
            }
        }
    }
}
