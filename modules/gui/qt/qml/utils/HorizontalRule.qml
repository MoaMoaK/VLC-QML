import QtQuick 2.0

Rectangle {
    property int size: parent.width
    property color c: "#000000"
    property real percent: 1

    anchors.horizontalCenter: parent.horizontalCenter

    height: 1
    width: size * percent
    color: c
}
