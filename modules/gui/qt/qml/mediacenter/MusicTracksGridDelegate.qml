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
            console.log('Clicked on details : '+model.track_title)
            medialib.select( index );
            mouse.accepted = false
        }

    }

    Column {
        x: 2
        y: 2
        id: column
        spacing: 5

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: root.height - title_disp.height - 4

            source: model.track_cover || "qrc:///noart.png"
        }

        Text {
            id: title_disp
            anchors.left: parent.left
            width: root.width - 4
            text: "<b>"+(model.track_title || "Unknown track")+"<b> - "+model.track_duration
            font.pixelSize: 12
            elide: Text.ElideRight
            height: implicitHeight+10

            Utils.ToolTipArea {
                anchors.fill: parent
                text: model.track_title || "Unknown track"
                enabled: title_disp.truncated
                attachedParent: root
            }
        }
    }
}
