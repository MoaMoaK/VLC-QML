/**************************************************************
 * The delegate to use to display an album inside a grid view
 **************************************************************/

import QtQuick 2.0
import QtGraphicalEffects 1.0

import "qrc:///utils/" as Utils

Rectangle {
    id: root
    color : medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

    MouseArea {
        id: mouseArea
        anchors.fill: root

        hoverEnabled: true
        onEntered: { root.color = medialib.isNightMode() ? vlc_style.hoverBgColor_nightmode : vlc_style.hoverBgColor_daymode }
        onExited: { root.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode }
        propagateComposedEvents: true

        onClicked: {
            console.log('Clicked on details : '+model.artist_name)
            medialib.select( index );
            mouse.accepted = false
        }

    }

    Column {
        x: 2
        y: 2
        id: column
        spacing: 5

        /* Display up to 4 preview of the artist's albums */
        Utils.ArtistCover {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: root.height - title_disp.height - 4

            albums: model.artist_albums
            nb_albums: model.artist_nb_albums
        }

        /* The name of the artist */
        Text {
            id: title_disp
            anchors.left: parent.left
            width: root.width - 4
            text: "<b>"+(model.artist_name || "Unknown Artist")+"<b>"
            font.pixelSize: 12
            elide: Text.ElideRight
            height: implicitHeight+10
            color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode

            Utils.ToolTipArea {
                anchors.fill: parent
                text: model.artist_name || "Unknown Artist"
                enabled: title_disp.truncated
                attachedParent: root
            }
        }
    }
}
