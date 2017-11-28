/*******************************************
 * The item displayed inside a grid view
 *******************************************/

import QtQuick 2.0

Rectangle {
    id: root

    property Component cover: Item {}
    property string name: ""
    property string date: ""
    property string infos: ""

    signal itemClicked
    signal playClicked

    color : medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

    MouseArea {
        id: mouseArea

        anchors.fill: root

        hoverEnabled: true
        onEntered: { root.color = medialib.isNightMode() ? vlc_style.hoverBgColor_nightmode : vlc_style.hoverBgColor_daymode }
        onExited: { root.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode }
        propagateComposedEvents: true

        onClicked: {
            root.itemClicked();
            mouse.accepted = false;
        }
    }

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
                    onClicked: root.playClicked()
                }
            }
        }

        /* A section with the infos about the album */
        Item {
            id: info_disp

            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width - 4
            height: name_text.height + 10

            /* The year of the album */
            Text {
                id: date_text

                anchors.left: name_text.right
                anchors.top: parent.top

                text: date
                font.pixelSize: 12
                color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
            }

            /* The title of the album elided */
            Text {
                id: name_text

                width: parent.width - date_text.implicitWidth
                anchors.left: parent.left
                anchors.top: parent.top

                elide: Text.ElideRight
                text: "<b>"+name+"</b>"
                font.pixelSize: 12
                color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode

                ToolTipArea {
                    anchors.fill: parent

                    text: name
                    enabled: name_text.truncated
                    attachedParent: root
                }
            }
        }





    }

}
