import QtQuick 2.0

ListView {

    property var tracks: []

    id: expand_track_id

    interactive: false
    model: tracks

    delegate: Rectangle {
        height: expand_track_name_id.font.pixelSize + 2
        width: expand_track_id.width

        Text {
            id: expand_track_name_id
            text: "["+tracks[index].getTrackNumber()+"] "+tracks[index].getTitle()+" - "+tracks[index].getDuration()
        }

        MouseArea {
            anchors.fill: parent

            hoverEnabled: true

            onEntered: { parent.color = "#f0f0f0" }
            onExited: { parent.color = "#ffffff" }
            onClicked: { console.log( "clicked : "+tracks[index].getTitle() ) }
        }
    }
}
