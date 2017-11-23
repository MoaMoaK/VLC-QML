import QtQuick 2.0
import QtQuick.Controls 2.0

import "qrc:///utils/" as Utils

Rectangle {
    id: root

    height: main_row.height
    width: parent.width
    color : medialib.isNightMode() ? "#000000" : "#ffffff"

    MouseArea {
        anchors.fill: root
        hoverEnabled: true
        propagateComposedEvents: true
        onEntered: { root.color = root.state === "expanded" ? (medialib.isNightMode() ? "#000000" : "#ffffff") : (medialib.isNightMode() ? "#0f0f0f" : "#f0f0f0") }
        onExited: { root.color = medialib.isNightMode() ? "#000000" : "#ffffff" }
        onClicked: {
            root.state = root.state === "" ? "expanded" : ""
            root.color = root.state === "expanded" ? (medialib.isNightMode() ? "#000000" : "#ffffff") : (medialib.isNightMode() ? "#0f0f0f" : "#f0f0f0")
            mouse.accepted = false
        }
    }

    Row {
        id: main_row
        height: cover.height
        spacing: 5

        Behavior on height { PropertyAnimation { duration: 100 } }

        Image {
            id: cover
            width: dimensions.icon_normal
            height: dimensions.icon_normal
            source: model.artist_cover || "qrc:///noart.png"

            Behavior on height { PropertyAnimation { duration: 100 } }
            Behavior on width { PropertyAnimation { duration: 100 } }
        }

        Column {
            id: main_column
            width: root.width - cover.width - main_row.spacing
            height: cover.height
            spacing : 5
            Text {
                id: title
                text : "<b>"+(model.artist_name || "Unknown artist")+"</b>"
                width: Math.min(parent.width, implicitWidth)
                height: implicitHeight
                elide: Text.ElideRight
                color: medialib.isNightMode() ? "#FFFFFF" : "#000000"
            }

            Utils.AlbumsDisplay {
                id: albumsDisplay
                x: 30
                height: artist_nb_albums * (2 + 12)
                width: main_column.width - x
                visible: false
                albums: artist_albums
            }
        }
    }

    states: State {
        name: "expanded"
        PropertyChanges { target: albumsDisplay; visible: true }
        PropertyChanges { target: cover; width: dimensions.icon_xlarge; height: dimensions.icon_xlarge}
        PropertyChanges { target: main_row; height: Math.max( cover.height, main_column.spacing*2 + title.height + albumsDisplay.height ) }
    }
}


