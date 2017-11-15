import QtQuick 2.0

import "qrc:///qml/"
//import "../utils"

Column {
    id: root
    spacing: 5

    Row {
        id: expand_row_id
        height: Math.max( expand_cover_id.height, expand_infos_id.height )
        spacing: 5

        Image {
            id: expand_cover_id
            width: 80
            height: 80
            source: model.album_cover || "qrc:///noart.png"
        }

        Column {
            id: expand_infos_id
            width: root.width - expand_cover_id.width - expand_row_id.spacing
            spacing: 5

            Text {
                text: "<b>"+(model.album_title || "Unknown title")+"</b>"
            }

            TracksDisplay {
                x: 30
                height: model.album_nb_tracks * (spacing + 2 + 12)
                width: expand_infos_id.width - x

                tracks: model.album_tracks
            }


        }
    }
}

