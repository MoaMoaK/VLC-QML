import QtQuick 2.0
import QtGraphicalEffects 1.0

import "qrc:///utils/" as Utils

Rectangle {
    id: root
    color : medialib.isNightMode() ? "#000000" : "#ffffff"

    MouseArea {
        id: mouseArea
        anchors.fill: root

        hoverEnabled: true
        onEntered: { root.color = medialib.isNightMode() ? "#0f0f0f" : "#f0f0f0" }
        onExited: { root.color = medialib.isNightMode() ? "#000000" : "#ffffff" }
        propagateComposedEvents: true

        onClicked: {
            console.log('Clicked on details : '+model.genre_name)
            medialib.select( index );
            mouse.accepted = false
        }
    }

    Column {
        x: 2
        y: 2
        id: column
        spacing: 5

        Utils.GenreCover {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: root.height - title_disp.height - 4

            albums: model.genre_albums
        }

        Text {
            id: title_disp
            anchors.left: parent.left
            width: root.width - 4
            text: "<b>"+(model.genre_name || "Unknown title")+"</b>"
            font.pixelSize: 12
            elide: Text.ElideRight
            height: implicitHeight+10
            color: medialib.isNightMode() ? "#FFFFFF" : "#000000"


            Utils.ToolTipArea {
                anchors.fill: parent
                text: model.album_title || "Unknown title"
                enabled: title_disp.truncated
                attachedParent: root
            }
        }
    }

}
