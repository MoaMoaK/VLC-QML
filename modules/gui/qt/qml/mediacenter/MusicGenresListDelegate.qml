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

    Text {
        id: collapse_title_id
        text : "<b>"+(model.genre_name || "Unknown track")+"</b> - "+model.genre_nb_tracks+" tracks"
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width-parent.spacing
        elide: Text.ElideRight
        color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
   }
}


