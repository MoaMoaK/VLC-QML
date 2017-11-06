import QtQuick 2.0

ListView {

    property var albums: []

    id: expand_album_id

    interactive: false
    model: albums

    delegate: Rectangle {
        height: expand_album_name_id.font.pixelSize + 2
        width: expand_album_id.width

        Text {
            id: expand_album_name_id
            text: "["+model.album_release_year+"] "+model.album_title+" - "+model.album_duration
        }

        MouseArea {
            anchors.fill: parent

            hoverEnabled: true

            onEntered: { parent.color = "#f0f0f0" }
            onExited: { parent.color = "#ffffff" }
            onClicked: { console.log( "clicked : "+model.album_title ) }
        }
    }
}
