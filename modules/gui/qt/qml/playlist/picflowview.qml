import QtQuick 2.0

Item {
    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 200
        height: 200
        color: "#ff00ff"

        Text {
            id: text1
            x: 44
            y: 56
            text: qsTr("picflowview")
            font.pixelSize: 12
        }
    }

}
