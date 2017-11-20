import QtQuick 2.0
import QtQuick.Controls 2.0

import "qrc:///utils/" as Utils

Rectangle {
    id: root

    height: collapse_row_id.height
    width: parent.width

    MouseArea {
        id: mouseArea_root_id
        anchors.fill: root

        hoverEnabled: true
        propagateComposedEvents: true
        onEntered: { root.color = root.state === "expanded" ? "#ffffff" : "#f0f0f0" }
        onExited: { root.color = "#ffffff" }
        onClicked: {
            root.state = root.state === "" ? "expanded" : ""
            root.color = root.state === "expanded" ? "#ffffff" : "#f0f0f0"
            mouse.accepted = false
        }
    }

    Row {
        id: collapse_row_id
        height: collapse_cover_id.height
        spacing: 5

        Behavior on height { PropertyAnimation { duration: 100 } }

        Image {
            id: collapse_cover_id
            width: dimensions.icon_normal
            height: dimensions.icon_normal
            source: model.album_cover || "qrc:///noart.png"

            Behavior on height { PropertyAnimation { duration: 100 } }
            Behavior on width { PropertyAnimation { duration: 100 } }
        }

        Column {
            id: collapse_column_id
            width: root.width - collapse_cover_id.width - collapse_row_id.spacing
            height: collapse_cover_id.height
            spacing : 5
            Text {
                id: collapse_title_id
                text : "<b>"+(model.album_title || "Unknown title")+"</b> ["+model.album_duration+"]"
                width: Math.min(parent.width, implicitWidth)
                height: implicitHeight
                elide: Text.ElideRight
            }

            Text {
                id: collapse_infos_id
                text: model.album_main_artist
                width: Math.min(parent.width, implicitWidth)
                height: implicitHeight
                elide: Text.ElideRight
                font.pixelSize: 8
            }

            Utils.TracksDisplay {
                id: trackDisplay
                x: 30
                height: album_nb_tracks * (2 + 12)
                width: collapse_column_id.width - x
                visible: false
                tracks: album_tracks
            }
        }
    }

    states: State {
        name: "expanded"
        PropertyChanges { target: trackDisplay; visible: true }
        PropertyChanges { target: collapse_cover_id; width: dimensions.icon_xlarge; height: dimensions.icon_xlarge}
        PropertyChanges { target: collapse_row_id; height: Math.max( collapse_cover_id.height, collapse_column_id.spacing*2 + collapse_title_id.height + collapse_infos_id.height + trackDisplay.height ) }
    }
}


