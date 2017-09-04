import QtQuick 2.0

Rectangle {

    property string buttonText: "button"
    property int h: 20
    property int w: 70
    property color buttonColor: "#eeeeee"
    property color borderColor: "#000000"
    property color textColor: "#000000"

    color: borderColor
    height: h
    width: w
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

        Text {
            anchors.centerIn: parent
            text: buttonText
            color: textColor
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: singleClick()
        onDoubleClicked: doubleClick()
    }

    function singleClick() { console.log("p"); }
    function doubleClick() { console.log("q"); }

}
