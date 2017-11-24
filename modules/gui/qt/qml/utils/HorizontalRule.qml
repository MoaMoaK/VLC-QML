/*******************************************************
 * A simple 1px-tall rectangle to use as an horizontal
 * rule of color 'c' and width 'size'*'percent'
 *******************************************************/
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
