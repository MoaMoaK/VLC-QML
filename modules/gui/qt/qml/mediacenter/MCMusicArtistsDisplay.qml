import QtQuick 2.0
import QtQuick.Controls 2.0


StackView {
    id: stack

    property var media
    property int viewDisplayed: 0
    property bool displayingInfo: false
    property var displayedItem

    function displayInfoArtist ( item ) {
        displayedItem = item;
        displayingInfo = true;
        stack.replace( infoArtist );
    }
    function hideInfoMovie () {
        if (displayingInfo) {
            displayingInfo = false;
            stack.replace( viewDisplayed == 0 ? gridView : listView );
        }
    }

    function cycleViews() {
        viewDisplayed = viewDisplayed == 0 ? 1 : 0;
        if (displayingInfo) { hideInfoMovie(); }
        else { stack.replace( viewDisplayed == 0 ? gridView : listView ); }
    }

    height : parent.height
    anchors.left: parent.left
    anchors.right: parent.right

    initialItem: viewDisplayed == 0 ? gridView : listView

    replaceEnter: Transition {
        PropertyAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 200
        }
    }
    replaceExit: Transition {
        PropertyAnimation {
            property: "opacity"
            from: 1
            to: 0
            duration: 200
        }
    }

    Component {
        id: gridView

        GridView {
            model: media

            cellWidth: 170
            cellHeight: 190

            delegate : MCGridArtistsDelegate {
                width: 170
                height: 190

                function showDetails ( item ) {
                    displayInfoArtist( item );
                }
            }

            ScrollBar.vertical: ScrollBar { }
        }
    }

    Component {
        id: listView

        ListView {
            model: media

            delegate : MCListAlbumsDelegate { }

            ScrollBar.vertical: ScrollBar { }
        }
    }

    Component {
        id: infoArtist

        MCArtistDetails {
            artist: displayedItem

            function back() {
                hideInfoMovie();
            }
        }
    }
}
