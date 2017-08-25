import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    width: 1000
    height: 1000

    Row {
        anchors.fill: parent

        Column {
            id: column
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width-300

            PLBannerSources {
                id: sourcesBanner
                z : 2
            }

            GridView {
                id: gridView
                z : 1
                height : parent.height - sourcesBanner.height
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

        ListView
        {
            id: listview
            z: 3
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 300
            model: playlist
            delegate: Text { text: '[' + model.duration + '] ' + model.display }
        }
    }




}
