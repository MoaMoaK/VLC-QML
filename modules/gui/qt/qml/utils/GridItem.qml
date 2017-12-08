/*******************************************
 * The item displayed inside a grid view
 *******************************************/

import QtQuick 2.0

MLItem {
    id: root

    property Component cover: Item {}
    property string name: ""
    property string date: ""
    property string infos: ""

    signal playClicked
    signal addToPlaylistClicked

    hovered: name_tooltip.containsMouse

    Column {
        id: column
        x: 2
        y: 2

        spacing: 5

        /* The full cover component with all added elements */
        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: root.height - info_disp.height - 4

            /* The cover */
            Loader {
                anchors.fill: parent
                sourceComponent: cover
            }

            /* Some infos displayed in the corner of the cover */
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                height: dur_disp.implicitHeight + 5
                width: infos === "" ? 0 : dur_disp.implicitWidth + 5

                color: medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

                Text {
                    id: dur_disp

                    anchors.centerIn: parent

                    text: infos
                    font.pixelSize: 10
                    color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
                }
            }

            Rectangle {
                anchors.fill: parent

                visible: root.active()
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#00"+vlc_style.vlc_orange.slice(1) }
                    GradientStop { position: 0.5; color: "#A0"+vlc_style.vlc_orange.slice(1) }
                    GradientStop { position: 1.0; color: "#FF"+vlc_style.vlc_orange.slice(1) }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: vlc_style.margin_xsmall
                    spacing: vlc_style.margin_xsmall

                    /* A addToPlaylist button visible when hovered */
                    Image {
                        height: vlc_style.icon_normal
                        width: vlc_style.icon_normal
                        fillMode: Image.PreserveAspectFit

                        visible: root.active()
                        source: "qrc:///buttons/playlist/playlist_add"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: root.addToPlaylistClicked()
                        }
                    }

                    /* A play button visible when hovered */
                    Image {
                        height: vlc_style.icon_normal
                        width: vlc_style.icon_normal
                        fillMode: Image.PreserveAspectFit

                        visible: root.active()
                        source: "qrc:///toolbar/play_b"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: root.playClicked()
                        }
                    }
                }
            }
        }

        /* A section with the infos about the album */
        Row {
            id: info_disp

            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: name_text.height + 10

            layoutDirection: Qt.RightToLeft

            /* The year of the album */
            Text {
                id: date_text

                width: implicitWidth
                height: implicitHeight

                text: date
                font.pixelSize: 12
                color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
            }

            /* The title of the album elided */
            Text {
                id: name_text

                width: parent.width - date_text.width
                height: implicitHeight

                elide: Text.ElideRight
                font.bold: true
                text: name
                font.pixelSize: 12
                color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode

                ToolTipArea {
                    id: name_tooltip
                    anchors.fill: parent
                    text: name
                    activated: parent.truncated
                }

            }
        }
    }
}
