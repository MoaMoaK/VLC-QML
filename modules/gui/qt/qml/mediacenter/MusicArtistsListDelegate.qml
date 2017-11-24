/**********************************************************
 * The delegate to display an artist inside the listView
 **********************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.0

import "qrc:///utils/" as Utils

Rectangle {
    id: root

    height: main_row.height
    width: parent.width

    color : medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

    MouseArea {
        anchors.fill: root

        hoverEnabled: true
        onEntered: { root.color = medialib.isNightMode() ? vlc_style.hoverBgColor_nightmode : vlc_style.hoverBgColor_daymode }
        onExited: { root.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode }
        onClicked: {
            console.log("Clicked on : "+model.artist_name);
            medialib.select( index );
        }
    }

    Row {
        id: main_row

        height: cover.height

        spacing: 5

        /* The cover of the artist */
        Image {
            id: cover

            width: vlc_style.icon_normal
            height: vlc_style.icon_normal

            source: model.artist_cover || "qrc:///noart.png"
        }

        /* The name of the artist */
        Text {
            id: title

            width: Math.min(parent.width, implicitWidth)
            height: implicitHeight

            text : "<b>"+(model.artist_name || "Unknown artist")+"</b>"
            elide: Text.ElideRight
            color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
        }
    }
}


