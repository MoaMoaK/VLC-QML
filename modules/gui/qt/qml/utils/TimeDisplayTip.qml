import QtQuick 2.0

Rectangle {

    property alias text: txt.text

    color:"white"
    border.width: 1
    border.color: "black"
    width: 50
    height: 20

    Text {
        id: txt
        text: "timing"
    }
}
