import QtQuick
import QtQuick.Effects

Item {
    anchors.fill: parent
    property int edgeSize: 10
    property int rounding: 14
    property string bgColor: "#f3ead3"

    Rectangle {
        anchors.fill: parent
        color: bgColor
        layer.enabled: true
        layer.effect: MultiEffect {
            maskSource: mask
            maskEnabled: true
            maskInverted: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
        }
    }

    Item {
        id: mask
        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
            anchors.fill: parent
            anchors.margins: edgeSize
            radius: rounding
        }
    }
}
