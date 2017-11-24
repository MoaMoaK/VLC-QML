/**********************************************************
 * The delegate to display an album inside the listView
 **********************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: root

    height: collapse_title_id.implicitHeight + 4
    width: parent.width

    color : medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

    MouseArea {
        id: mouseArea_root_id

        anchors.fill: root

        hoverEnabled: true
        onEntered: { root.color = medialib.isNightMode() ? vlc_style.hoverBgColor_nightmode : vlc_style.hoverBgColor_daymode }
        onExited: { root.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode }
        onClicked: {
            console.log("Clicked on : "+model.genre_name);
            medialib.select( index );
        }
    }

    /* The name of the genre and the number of track associated */
    Text {
        id: collapse_title_id

        anchors.verticalCenter: parent.verticalCenter
        width: parent.width-parent.spacing

        text : "<b>"+(model.genre_name || "Unknown track")+"</b> - "+model.genre_nb_tracks+" tracks"
        elide: Text.ElideRight
        color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
   }
}


