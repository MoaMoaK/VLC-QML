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
            console.log('Clicked on details : '+model.album_title)
            mouse.accepted = false
        }
    }

    Column {
        id: column

        x: 2
        y: 2

        spacing: 5

        /* The full cover component with all added infos */
        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: root.height - info_disp.height - 4

            /* The cover */
            Image {
                id: img

                anchors.fill: parent

                source: model.album_cover || "qrc:///noart.png"
            }

            /* The duration and number of tracks displayed in the corner of the cover */
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                height: dur_disp.implicitHeight + 5
                width: dur_disp.implicitWidth + 5

                color: medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

                Text {
                    id: dur_disp

                    anchors.centerIn: parent

                    text: model.album_duration + " - " + model.album_nb_tracks + " tracks"
                    font.pixelSize: 10
                    color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
                }
            }

            /* A play button appearing when hovering */
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
                    anchors.centerIn: parent

                    source: "qrc:///toolbar/play_b"
                }

                MouseArea{
                    anchors.fill: parent

                    hoverEnabled: true
                    onEntered: { parent.opacity = 0.7; root.color = medialib.isNightMode() ? vlc_style.hoverBgColor_nightmode : vlc_style.hoverBgColor_daymode; }
                    onExited: { parent.opacity = 0 ; root.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode;}
                    onClicked: console.log('Clicked on play : '+model.album_title)
                }
            }
        }

        /* A section with the infos about the album */
        Item {
            id: info_disp

            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: title_disp.height + 10

            /* The year of the album */
            Text {
                id: year_disp

                anchors.left: title_disp.right
                anchors.top: parent.top

                text: model.album_release_year !== "0" ? model.album_release_year : ""
                font.pixelSize: 12
                color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
            }

            /* The title of the album elided */
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
