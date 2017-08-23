import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    width: 1000
    height: 1000

    Column {
        id: column
        anchors.fill: parent

        PLBannerSources {
            id: sourcesBanner
        }

        GridView {
            id: gridView
            z : 1
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: sourcesBanner.bottom
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.left: parent.left
            cellWidth: 150
            cellHeight: 150
            model: m
            delegate: GridViewDelegate {
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
    }


}
