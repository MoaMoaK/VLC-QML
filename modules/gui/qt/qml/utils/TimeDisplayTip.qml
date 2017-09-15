import QtQuick 2.0


Column {
    spacing: 0
    property alias text: txt.text
    Rectangle {
        x:0
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

    Triangle {
        x: parent.width/2 - width/2
        strokeStyle: "#000000"
        triangleHeight: height
        triangleWidth: width
        height: 10
        width: 10
        lineWidth: 1
        direction: "down"
    }
}
