import QtQuick 2.0

ListView {

    property var albums: []

    id: expand_album_id

    interactive: false
    model: albums

    delegate: Rectangle {
        height: expand_album_name_id.font.pixelSize + 2
        width: expand_album_id.width
        color : medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

        Text {
            id: expand_album_name_id
            text: "["+model.album_release_year+"] "+model.album_title+" - "+model.album_duration
            color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
        }

        MouseArea {
            anchors.fill: parent

            hoverEnabled: true

            onEntered: { parent.color = medialib.isNightMode() ? vlc_style.hoverColor_nightmode : vlc_style.hoverColor_daymode }
            onExited: { parent.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode }
            onClicked: { console.log( "clicked : "+model.album_title ) }
        }
    }
}
