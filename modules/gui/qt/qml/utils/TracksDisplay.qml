import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    property var tracks: []

    ListView {
        id: expand_track_id

        anchors.fill: parent

        model: tracks

        delegate: Rectangle {
            height: expand_track_name_id.font.pixelSize + 2
            width: expand_track_id.width

            Text {
                id: expand_track_name_id
                text: "["+model.track_number+"] "+model.track_title+" - "+model.track_duration
            }

            MouseArea {
                anchors.fill: parent

                hoverEnabled: true

                onEntered: { parent.color = "#f0f0f0" }
                onExited: { parent.color = "#ffffff" }
                onClicked: { console.log( "clicked : "+model.track_title ) }
            }
        }

        ScrollBar.vertical: ScrollBar { }
    }

}

