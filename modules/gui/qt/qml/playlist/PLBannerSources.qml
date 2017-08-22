import QtQuick 2.0

Item {
    id: item1
    Rectangle {
        id: rectangle
        y: 0
        height: 32
        color: "#e6e6e6"
        anchors.left: parent.left
        anchors.right: parent.right

        Row {
            id: row
            spacing: 20
            anchors.fill: parent

            Text {
                id: text1
                text: qsTr("Movies")
                verticalAlignment: Text.AlignVCenter
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 12

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                }
            }

            Text {
                id: text2
                text: qsTr("Series")
                anchors.bottom: parent.bottom
                MouseArea {
                    id: mouseArea1
                    anchors.fill: parent
                }
                anchors.top: parent.top
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: text3
                text: qsTr("Musics")
                anchors.bottom: parent.bottom
                MouseArea {
                    id: mouseArea2
                    anchors.fill: parent
                }
                anchors.top: parent.top
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

}
