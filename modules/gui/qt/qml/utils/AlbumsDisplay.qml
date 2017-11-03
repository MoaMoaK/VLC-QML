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
            text: "["+albums[index].getReleaseYear()+"] "+albums[index].getTitle()+" - "+albums[index].getDuration()
        }

        MouseArea {
            anchors.fill: parent

            hoverEnabled: true

            onEntered: { parent.color = "#f0f0f0" }
            onExited: { parent.color = "#ffffff" }
            onClicked: { console.log( "clicked : "+albums[index].getTitle() ) }
        }
    }
}
