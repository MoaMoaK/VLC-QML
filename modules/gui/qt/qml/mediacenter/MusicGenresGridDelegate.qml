import QtQuick 2.0
import QtGraphicalEffects 1.0

import "qrc:///utils/" as Utils

Rectangle {
    id: root

    MouseArea {
        id: mouseArea
        anchors.fill: root

        hoverEnabled: true
        onEntered: { root.color = "#f0f0f0" }
        onExited: { root.color = "#ffffff" }
        propagateComposedEvents: true

        onClicked: {
            console.log('Clicked on details : '+model.genre_name)
            medialib.select( index );
            mouse.accepted = false
        }
    }

    Text {
        id: title_disp
        width: root.width - 4
        anchors.left: parent.left
        text: "<b>"+(model.genre_name || "Unknown title")+"</b>"
        font.pixelSize: 12
        elide: Text.ElideRight
        height: implicitHeight+10


        Utils.ToolTipArea {
            anchors.fill: parent
            text: model.album_title || "Unknown title"
            enabled: title_disp.truncated
            attachedParent: root
        }
    }

}
