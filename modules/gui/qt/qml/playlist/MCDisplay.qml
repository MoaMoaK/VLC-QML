import QtQuick 2.0

GridView {
    id: mcDisplay

    property alias media: mcDisplay.model

    cellWidth: 150
    cellHeight: 150

    delegate: MCGridViewDelegate {
        cover: model.cover
        title: model.title
        album: model.album
        artist: model.artist
        uri: model.uri
        duration: model.duration

        function singleClick() { model.display_info = 1}
        function doubleClick() { model.activate_item = 1}

    }


}
