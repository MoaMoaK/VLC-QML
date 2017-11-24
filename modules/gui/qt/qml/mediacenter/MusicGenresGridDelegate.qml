/**************************************************************
 * The delegate to use to display a genre inside a grid view
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
        propagateComposedEvents: true
        onEntered: { root.color = medialib.isNightMode() ? vlc_style.hoverBgColor_nightmode : vlc_style.hoverBgColor_daymode }
        onExited: { root.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode }
        onClicked: {
            console.log('Clicked on details : '+model.genre_name)
            medialib.select( index );
            mouse.accepted = false
        }
    }

    Column {
        id: column

        x: 2
        y: 2

        spacing: 5

        /* Display up to 4 preview of the genre's albums */
        Utils.GenreCover {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: root.height - title_disp.height - 4

            albums: model.genre_albums
        }

        /* The name of the artist */
        Text {
            id: title_disp

            anchors.left: parent.left
            width: root.width - 4
            height: implicitHeight+10

            text: "<b>"+(model.genre_name || "Unknown title")+"</b>"
            font.pixelSize: 12
            elide: Text.ElideRight
            color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode

            Utils.ToolTipArea {
                anchors.fill: parent

                text: model.album_title || "Unknown title"
                enabled: title_disp.truncated
                attachedParent: root
            }
        }
    }

}
