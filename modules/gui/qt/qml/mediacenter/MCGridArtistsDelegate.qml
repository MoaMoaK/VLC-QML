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
            console.log('Clicked on details : '+model.name)
            showDetails( model.artist );
            mouse.accepted = false
        }

    }

    Column {
        x: 2
        y: 2
        id: column
        spacing: 5

        Grid {
            id: grid_cover_id
            columns: 2
            spacing: 2

            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: root.height - title_disp.height - 4

            Repeater {
                model: Math.min(nb_albums, 4)

                Image {
                    id: img
                    source: albums[modelData].getCover() || "qrc:///noart.png"
                    height: nb_albums == 1 ? grid_cover_id.height : (grid_cover_id.height/grid_cover_id.columns) - 1
                    width: nb_albums == 1 ? grid_cover_id.width : (grid_cover_id.width/grid_cover_id.columns) - 1
                }

            }
        }

        Text {
            id: title_disp
            anchors.left: parent.left
            width: root.width - 4
            text: "<b>"+(model.name || "Plop")+"<b>"
            font.pixelSize: 12
            elide: Text.ElideRight
            height: implicitHeight+10

            ToolTipArea {
                anchors.fill: parent
                text: model.title || "Unknown Artist"
                enabled: title_disp.truncated
                attachedParent: root
            }
        }
    }
}
