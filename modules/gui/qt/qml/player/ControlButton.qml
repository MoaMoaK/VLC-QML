import QtQuick 2.0

import "qrc:///qml/"
//import "../utils/"

Rectangle {

    property int size: 32
    property string iconURL: "qrc:///noart.png"
    property color buttonColor: "#eeeeee"
    property color borderColor: "#bbbbbb"
    property bool isbig: false
    property string name: "noname"

    color: borderColor
    height: size
    width: size
    radius: 5

    Rectangle {
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            left: parent.left
            topMargin: 3
            rightMargin: 3
            bottomMargin: 3
            leftMargin: 3
        }
        radius: 2

        color: buttonColor

        Image {
            height: size-8; width: size-8
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectFit
            source: iconURL
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: singleClick()
        onDoubleClicked: doubleClick()
        propagateComposedEvents: true
    }

    ToolTipArea {
        text: name
    }

    function singleClick() { console.log("Clicked on "+name); }
    function doubleClick() { console.log("Double clicked on "+name); }

}
