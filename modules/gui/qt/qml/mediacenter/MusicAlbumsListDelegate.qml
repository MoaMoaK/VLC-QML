/**********************************************************
 * The delegate to display an album inside the listView
 **********************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.0

import "qrc:///utils/" as Utils

Rectangle {
    id: root

    height: main_row.height
    width: parent.width

    color : medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

    MouseArea {
        anchors.fill: root

        hoverEnabled: true
        propagateComposedEvents: true
        onEntered: { root.color = root.state === "expanded" ? (medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode) : (medialib.isNightMode() ? vlc_style.hoverBgColor_nightmode : vlc_style.hoverBgColor_daymode) }
        onExited: { root.color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode }
        onClicked: {
            root.state = root.state === "" ? "expanded" : ""
            root.color = root.state === "expanded" ? (medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode) : (medialib.isNightMode() ? vlc_style.hoverBgColor_nightmode : vlc_style.hoverBgColor_daymode)
            mouse.accepted = false
        }
    }

    Row {
        id: main_row

        height: cover.height

        spacing: 5

        Behavior on height { PropertyAnimation { duration: 100 } }

        /* The cover of the album */
        Image {
            id: cover

            width: vlc_style.icon_normal
            height: vlc_style.icon_normal

            source: model.album_cover || "qrc:///noart.png"

            Behavior on height { PropertyAnimation { duration: 100 } }
            Behavior on width { PropertyAnimation { duration: 100 } }
        }

        Column {
            id: main_column

            width: root.width - cover.width - main_row.spacing
            height: cover.height

            spacing : 5

            /* The title of the album */
            Text {
                id: title

                width: Math.min(parent.width, implicitWidth)
                height: implicitHeight

                text : "<b>"+(model.album_title || "Unknown title")+"</b> ["+model.album_duration+"]"
                color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
                elide: Text.ElideRight
            }

            /* The name of the main artist */
            Text {
                id: infos

                width: Math.min(parent.width, implicitWidth)
                height: implicitHeight

                text: model.album_main_artist
                color: medialib.isNightMode() ? vlc_style.textColor_nightmode : vlc_style.textColor_daymode
                elide: Text.ElideRight
                font.pixelSize: 8
            }

            /* The list of the tracks only visible if the item was clicked (state = expanded) */
            Utils.TracksDisplay {
                id: tracksDisplay

                x: 30
                height: album_nb_tracks * (2 + 12)
                width: main_column.width - x

                tracks: album_tracks

                visible: false
            }
        }
    }

    states: State {
        name: "expanded"
        PropertyChanges { target: tracksDisplay; visible: true }
        PropertyChanges { target: cover; width: vlc_style.icon_xlarge; height: vlc_style.icon_xlarge}
        PropertyChanges { target: main_row; height: Math.max( cover.height, main_column.spacing*2 + title.height + infos.height + tracksDisplay.height ) }
    }
}


