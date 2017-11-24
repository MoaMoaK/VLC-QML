/********************************************************
 * The delegate to use for the expanded zone inside a
 * GridExpandView that appears when an album is clicked
 ********************************************************/

import QtQuick 2.0

import "qrc:///utils/" as Utils

Row {
    id: root
    spacing: 5
    x: 5

    /* A bigger cover for the album */
    Image {
        id: expand_cover_id
        width: vlc_style.cover_large
        height: vlc_style.cover_large
        source: model.album_cover || "qrc:///noart.png"
    }

    Column {
        id: expand_infos_id
        width: root.width - expand_cover_id.width - root.spacing
        spacing: 5

        /* The title of the albums */
        // Needs a rectangle too prevent the tracks from overlapping the title when scrolled
        Rectangle {
            id: expand_infos_titleRect_id
            color: medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode
            height: expand_infos_title_id.implicitHeight
            width: expand_infos_id.width

            Text {
                id: expand_infos_title_id
                text: "<b>"+(model.album_title || "Unknown title")+"</b>"
                color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
            }
        }

        /* The list of the tracks available */
        Utils.TracksDisplay {
            x: 30
            z: expand_infos_titleRect_id.z - 1
            height: Math.min(root.height - expand_infos_titleRect_id.height - expand_infos_id.spacing, model.album_nb_tracks * (expand_infos_id.spacing + 2 + 12) - expand_infos_id.spacing)
            width: expand_infos_id.width - x

            tracks: model.album_tracks
        }
    }
}

