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

    color : medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

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
            width: parent.width - cover_loader.width - spacing

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
    }
}


