import QtQuick 2.0
import QtQuick.Controls 2.0


StackView {
    id: stack

    property var media
    property int viewDisplayed: 0
    property bool displayingInfo: false
    property var displayedItem

    function displayInfoMovie (pl_item) {
        displayedItem = pl_item;
        displayingInfo = true;
        stack.replace( infoMovie );
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
            id: sub_gridView
            model: media
            cellWidth: 150
            cellHeight: 150

            delegate: MCGridViewDelegate {
                cover: model.cover
                title: model.title
                album: model.album
                artist: model.artist
                uri: model.uri
                duration: model.duration
                is_leaf: model.leaf_node

                width: sub_gridView.cellWidth
                height: sub_gridView.cellHeight

                function singleClick() {
                    if (model.is_movie) { displayInfoMovie(model); }
                    else { model.single_click = 1; }
                }
                function doubleClick() { model.double_click = 1; }
            }

            ScrollBar.vertical: ScrollBar { }
        }
    }

    Component {
        id: listView

        ListView {
            model: media

            delegate: MCListViewDelegate {
                cover: model.cover
                title: model.title
                album: model.album
                artist: model.artist
                uri: model.uri
                duration: model.duration
                is_leaf: model.leaf_node

                function singleClick() {
                    if (model.is_movie) { displayInfoMovie(model); }
                    else { model.single_click = 1; }
                }
                function doubleClick() { model.double_click = 1 }
           }

            ScrollBar.vertical: ScrollBar { }
        }
    }

    Component {
        id: infoMovie

        InfoMovie {
            pl_item: displayedItem

            function back() { hideInfoMovie(); }
        }
    }

}

