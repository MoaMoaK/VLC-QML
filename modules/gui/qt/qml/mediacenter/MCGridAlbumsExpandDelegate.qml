import QtQuick 2.0

import "qrc:///qml/" as Utils
//import "../utils"

Row {
    id: root
    spacing: 5

    Image {
        id: expand_cover_id
        width: dimensions.cover_large
        height: dimensions.cover_large
        source: model.album_cover || "qrc:///noart.png"
    }

    Column {
        id: expand_infos_id
        width: root.width - expand_cover_id.width - root.spacing
        spacing: 5

        Text {
            text: "<b>"+(model.album_title || "Unknown title")+"</b>"
        }

        Utils.TracksDisplay {
            x: 30
            height: model.album_nb_tracks * (spacing + 2 + 12)
            width: expand_infos_id.width - x

            tracks: model.album_tracks
        }


    }
}

