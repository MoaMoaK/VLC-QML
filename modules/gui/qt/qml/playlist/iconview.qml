import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

Item {
    width: 1000
    height: 1000

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        Column {
            id: column
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Layout.fillWidth: true
            Layout.minimumWidth: 500

            BannerSources {
                id: sourcesBanner
                z : 2
            }

            MCDisplay {
                media : m
                z: 1
                height : parent.height - sourcesBanner.height
                anchors.right: parent.right
                anchors.left: parent.left
            }

        }

        PLDisplay {
            pl: playlist
            z: 3
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Layout.maximumWidth: 400
        }
    }




}
