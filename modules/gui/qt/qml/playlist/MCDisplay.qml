import QtQuick 2.0
import QtQuick.Controls 2.0


StackView {
    id: stack

    property var media
    property int viewDisplayed: 0

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

    function toggleView () {
        viewDisplayed = viewDisplayed == 0 ? 1 : 0
        stack.replace(viewDisplayed == 0 ? gridView : listView)
    }

    Component {
        id: gridView

        GridView {
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

                function singleClick() { model.display_info = 1 }
                function doubleClick() { model.activate_item = 1 }
           }

            ScrollBar.vertical: ScrollBar { }
        }
    }

    Component {
        id: listView

        ListView {
            model: media

            delegate: Text {
                text: "popo"
            }
        }
    }

}

