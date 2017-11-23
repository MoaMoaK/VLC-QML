import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    property var tracks: []

    ListView {
        id: expand_track_id

        anchors.fill: parent

        model: tracks

        delegate: Rectangle {
            height: expand_track_name_id.font.pixelSize + 2
            width: expand_track_id.width
            color : medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

            Text {
                id: expand_track_name_id
                text: "["+model.track_number+"] "+model.track_title+" - "+model.track_duration
                color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
            }

            MouseArea {
                anchors.fill: parent

                hoverEnabled: true

                onEntered: { parent.color = medialib.isNightMode() ? vlc_style.hoverColor_nightmode : vlc_style.hoverColor_daymode }
                onExited: { parent.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode }
                onClicked: { console.log( "clicked : "+model.track_title ) }
            }
        }

        ScrollBar.vertical: ScrollBar { }
    }

}

