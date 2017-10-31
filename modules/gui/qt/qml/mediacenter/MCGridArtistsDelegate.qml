import QtQuick 2.0
import QtGraphicalEffects 1.0

import "qrc:///qml/"
//import "../utils"

Rectangle {
    id: root

    function showDetails() {
        // To be implemented by the parent
        return ;
    }

    MouseArea {
        id: mouseArea
        anchors.fill: root

        hoverEnabled: true
        onEntered: { root.color = "#f0f0f0" }
        onExited: { root.color = "#ffffff" }
        propagateComposedEvents: true

        onClicked: {
            console.log('Clicked on details : '+modelData.getName())
            showDetails( modelData );
            mouse.accepted = false
        }

    }

    Column {
        x: 2
        y: 2
        id: column
        spacing: 5

        ArtistCover {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: root.height - title_disp.height - 4

            albums: modelData.getAlbums()
            nb_albums: modelData.getNbAlbums()
        }

        Text {
            id: title_disp
            anchors.left: parent.left
            width: root.width - 4
            text: "<b>"+(modelData.getName() || "Plop")+"<b>"
            font.pixelSize: 12
            elide: Text.ElideRight
            height: implicitHeight+10

            ToolTipArea {
                anchors.fill: parent
                text: modelData.getName() || "Unknown Artist"
                enabled: title_disp.truncated
                attachedParent: root
            }
        }
    }
}
