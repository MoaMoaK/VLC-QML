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
        onEntered: { root.color = medialib.isNightMode() ? vlc_style.hoverColor_nightmode : vlc_style.hoverColor_daymode }
        onExited: { root.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode }
        propagateComposedEvents: true

        onClicked: {
            console.log('Clicked on details : '+model.album_title)
            mouse.accepted = false
        }
    }

    Column {
        x: 2
        y: 2
        id: column
        spacing: 5

        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: root.height - info_disp.height - 4

            Image {
                id: img
                source: model.album_cover || "qrc:///noart.png"

                anchors.fill: parent
            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.right: parent.right

                color: medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

                height: dur_disp.implicitHeight + 5
                width: dur_disp.implicitWidth + 5

                Text {
                    id: dur_disp
                    anchors.centerIn: parent
                    text: model.album_duration + " - " + model.album_nb_tracks + " tracks"
                    font.pixelSize: 10
                    color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
                }
            }

            Rectangle {
                id: playbutton
                anchors.top: parent.top
                anchors.right: parent.right

                width: parent.width / 2
                height: parent.width / 2

                radius: Math.min( width, height )

                opacity: 0
                color: "#E1A244"

                Image {
                    source: "qrc:///toolbar/play_b"
                    anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent

                    hoverEnabled: true
                    onEntered: { parent.opacity = 0.7; root.color = medialib.isNightMode() ? vlc_style.hoverColor_nightmode : vlc_style.hoverColor_daymode; }
                    onExited: { parent.opacity = 0 ; root.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode;}

                    onClicked: console.log('Clicked on play : '+model.album_title)
                }
            }
        }

        Item {
            id: info_disp
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: title_disp.height + 10

            Text {
                id: year_disp
                anchors.left: title_disp.right
                anchors.top: parent.top
                text: model.album_release_year !== "0" ? model.album_release_year : ""
                font.pixelSize: 12
                color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
            }

            Text {
                id: title_disp
                width: parent.width - year_disp.implicitWidth
                anchors.left: parent.left
                anchors.top: parent.top
                elide: Text.ElideRight
                text: "<b>"+(model.album_title || "Unknown title")+"</b>"
                font.pixelSize: 12
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

}
