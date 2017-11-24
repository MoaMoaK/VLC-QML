/***********************************************
 * A component to display a listview of albums
 ***********************************************/

import QtQuick 2.0

ListView {
    id: expand_album_id

    property var albums: []

    interactive: false
    model: albums
    delegate: Rectangle {
        height: expand_album_name_id.font.pixelSize + 2
        width: expand_album_id.width

        color : medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

        /* The infos about the album */
        // Format : [release_year] title - duration
        Text {
            id: expand_album_name_id

            text: "["+model.album_release_year+"] "+model.album_title+" - "+model.album_duration
            color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
        }

        MouseArea {
            anchors.fill: parent

            hoverEnabled: true
            onEntered: { parent.color = medialib.isNightMode() ? vlc_style.hoverBgColor_nightmode : vlc_style.hoverBgColor_daymode }
            onExited: { parent.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode }
            onClicked: { console.log( "clicked : "+model.album_title ) }
        }
    }
}
