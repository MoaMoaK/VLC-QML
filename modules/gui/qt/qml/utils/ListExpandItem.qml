/*********************************************
 * The item displayed inside the listView
 *********************************************/

import QtQuick 2.0

MLItem {
    id: root

    property Component cover: Item{}
    property Component line1: Item{}
    property Component line2: Item{}
    property Component expand: Item{}

    signal playClicked
    signal addToPlaylistClicked

    onItemClicked: root.state = root.state === "expanded" ? "" : "expanded"
    force_disable: root.state === "expanded"

    Row {
        id: main_row

        anchors.fill: parent

        spacing: 5

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
                id: line1_loader

                width: parent.width

                sourceComponent: line1
            }

            /* Line 2 */
            Loader {
                id: line2_loader

                width: parent.width

                sourceComponent: line2
            }

            /* Expand */
            Loader {
                id: expand_loader

                width: parent.width

                visible: false
                sourceComponent: expand
            }
        }

        /* The icon to add to playlist */
        Image {
            id: add_to_playlist_icon

            anchors.verticalCenter: parent.verticalCenter
            width: vlc_style.icon_small
            height: vlc_style.icon_small

            visible: root.active()
            source: "qrc:///buttons/playlist/playlist_add"

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
            source: "qrc:///toolbar/play_b"

            MouseArea {
                anchors.fill: parent

                onClicked: root.playClicked()
            }
        }
    }

    states: State {
        name: "expanded"
        PropertyChanges { target: expand_loader; visible: true }
        PropertyChanges { target: cover_loader.item; state: "expanded"}
        PropertyChanges { target: root; height: Math.max( cover_loader.item.height, line1_loader.item.height + line2_loader.item.height + expand_loader.item.height ) }
    }
}


