import QtQuick 2.0


Row {

    property bool cur
    property string title
    property string duration

    spacing: 0
    height: 15
    width: parent.width

    Rectangle {
        id: removeButton
        color: "#FF0000"
        height: parent.height
        width: parent.height

        MouseArea {
            anchors.fill: parent
            onClicked: { remove(); }
        }
    }

    Rectangle {

        color: cur ? "#CCCCCC" : "#FFFFFF"
        width : parent.width - removeButton.width
        height:  textInfo.implicitHeight

        Text {
            id: textInfo
            x: 10
            text: duration ? '[' + duration + '] ' + (title ? title : "") : (title ? title : "")
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.color = cur ? "#BBBBBB" : "#EEEEEE"
            }
            onExited: {
                parent.color = cur ? "#CCCCCC" : "#FFFFFF"
            }
            onClicked: { singleClick(); }
            onDoubleClicked: { doubleClick(); }
        }

    }
}
