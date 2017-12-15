/***********************************************
 * The main component to display the playlist
 * on the right side of the screen
 ***********************************************/

import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: plDisplay

    property int default_width: 300

    // Force to recalculate the colors
    function changedNightMode() {
        color = medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode
        reloadData();
    }

    // Force the data inside the listview to de reloaded
    function reloadData() {
        listView.model = [];
        listView.model = playlist;
    }

    width: default_width
    color: medialib.isNightMode() ? vlc_style.bgColor_nightmode : vlc_style.bgColor_daymode

    /* Button to show/hide the playlist */
    Image {
        id: toogleBar

        x: -20
        width: 20
        height: 20

        fillMode: Image.PreserveAspectFit
        source: "qrc:///toolbar/playlist.svg"
        mirror: plDisplay.width <= 20 ? true : false

        MouseArea {
            anchors.fill: parent
            onClicked: { plDisplay.width <= 20 ? openAnimation.running = true : closeAnimation.running = true }
        }
    }

    /* List of items in the playlist */
    PlaylistListView {
        id: listView

        height: parent.height
        width: parent.width

        vertSpace: 2
        horiSpace: 5
        model: playlist
        dataFunc: function( elt ) { return elt.album_title; }
        delegate: PLItem {}
        delegateGrouped: PLItem {}
        commonGrouped: Image {
            width: vlc_style.cover_xsmall
            height: vlc_style.cover_xsmall

            fillMode: Image.PreserveAspectFit
            source: model !== undefined ? (model.cover || "qrc:///noart.png") : "qrc:///noart.png"
        }

        ScrollBar.vertical: ScrollBar { }
    }

    /* Hiding animation of the playlist */
    PropertyAnimation {
        id: closeAnimation

        target: plDisplay
        properties: "width"
        duration: 1000
        to: 0
        easing.type: Easing.InOutCubic
    }

    /* Showing animation of the playlist */
    PropertyAnimation {
        id: openAnimation

        target: plDisplay
        properties: "width"
        duration: 1000
        to: default_width
        easing.type: Easing.InOutCubic
    }

}


