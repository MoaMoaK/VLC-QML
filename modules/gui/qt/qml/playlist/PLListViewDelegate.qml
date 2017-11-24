/*********************************************************
 * The delegate used to display an item in the playlist
 *********************************************************/
import QtQuick 2.0

Row {

    property bool cur: false
    property string title
    property string duration

    height: bg.height
    width: parent.width

    spacing: 0

    /* Button to remove this item from playlist */
    Image {
        id: removeButton

        height: parent.height
        width: parent.height

        source: "qrc:///toolbar/clear"
        fillMode: Image.PreserveAspectFit

        MouseArea {
            anchors.fill: parent

            onClicked: { remove(); }
            hoverEnabled: true
            onEntered: {
                bg.color = "#CC0000"
                textInfo.color = "#FFFFFF"
            }
            onExited: {
                bg.color = cur ? "#CCCCCC" : "#FFFFFF"
                textInfo.color = "#000000"
            }
        }
    }

    Rectangle {
        id: bg

        width : parent.width - removeButton.width
        height:  textInfo.height

        color: cur ? "#CCCCCC" : "#FFFFFF"

        /* Title/name of the item */
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
