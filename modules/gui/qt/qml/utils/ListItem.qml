/*********************************************
 * The item displayed inside the listView
 *********************************************/

import QtQuick 2.0

MLItem {
    id: root

    property Component cover: Item{}
    property Component line1: Item{}
    property Component line2: Item{}

    signal playClicked
    signal addToPlaylistClicked

    Row {
        id: main_row

        anchors.fill: parent

        spacing: vlc_style.margin_small

        /* The cover */
        Loader {
            id: cover_loader

            sourceComponent: cover
        }

        Column {
            height: parent.height
            width: parent.width - cover_loader.width - parent.spacing*3 - add_to_playlist_icon.width - add_and_play_icon.anchors.rightMargin - add_and_play_icon.width

            /* Line 1 */
            Loader {
                width: parent.width

                sourceComponent: line1
            }

            /* Line 2 */
            Loader {
                width: parent.width

                sourceComponent: line2
            }
        }

        /* The icon to add to playlist */
        Image {
            id: add_to_playlist_icon

            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: vlc_style.margin_small
            width: vlc_style.icon_small
            height: vlc_style.icon_small

            visible: root.active()
            source: "qrc:///buttons/playlist/playlist_add.svg"

            MouseArea {
                anchors.fill: parent

                onClicked: root.addToPlaylistClicked()
            }
        }

        /* The icon to add to playlist and play */
        Image {
            id: add_and_play_icon

            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: vlc_style.margin_small
            width: vlc_style.icon_small
            height: vlc_style.icon_small

            visible: root.active()
            source: "qrc:///toolbar/play_b.svg"

            MouseArea {
                anchors.fill: parent

                onClicked: root.playClicked()
            }
        }
    }
}
