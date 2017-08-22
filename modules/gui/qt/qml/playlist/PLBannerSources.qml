import QtQuick 2.0

Rectangle {
    id: pLBannerSources
    z : 2
    height: 32
    color: "#e6e6e6"
    anchors.left: parent.left
    anchors.right: parent.right

    Row {
        spacing: 20
        anchors.fill: parent

        Text {
            text: qsTr("Movies")
            verticalAlignment: Text.AlignVCenter
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font.pixelSize: 12
            MouseArea {
                anchors.fill: parent
                onClicked: selector.setSourceFromName(2)
            }
        }

        Text {
            text: qsTr("Music")
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            font.pixelSize: 12
            verticalAlignment: Text.AlignVCenter
            MouseArea {
                anchors.fill: parent
                onClicked: selector.setSourceFromName(3)
            }
        }

        Text {
            text: qsTr("Pictures")
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            font.pixelSize: 12
            verticalAlignment: Text.AlignVCenter
            MouseArea {
                anchors.fill: parent
                onClicked: selector.setSourceFromName(4)
            }
        }
    }
}
