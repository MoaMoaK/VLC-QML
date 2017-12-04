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
        source: "qrc:///toolbar/playlist"
        mirror: plDisplay.width <= 20 ? true : false

        MouseArea {
            anchors.fill: parent
            onClicked: { plDisplay.width <= 20 ? openAnimation.running = true : closeAnimation.running = true }
        }
    }

    /* List of items in the playlist */
    ListView {
        id: listView

        height: parent.height
        width: parent.width

        model: playlist

        delegate: PLListViewDelegate {
            function singleClick() { }
            function doubleClick() { model.activate_item = 1 }
            function remove() { model.remove_item = 1 }

            cur: model.current
            title: model.title
            duration: model.duration
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


