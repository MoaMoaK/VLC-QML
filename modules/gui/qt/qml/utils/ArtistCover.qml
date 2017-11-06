import QtQuick 2.0

Grid {

    property var albums: undefined
    property int nb_albums: 0

    id: gridCover_id
    columns: 2
    spacing: 2

    Repeater {
        model: albums

        Image {
            id: img
            source: model.album_cover || "qrc:///noart.png"
            height: nb_albums == 1 ? gridCover_id.height : (gridCover_id.height/gridCover_id.columns) - 1
            width: nb_albums == 1 ? gridCover_id.width : (gridCover_id.width/gridCover_id.columns) - 1
            fillMode: Image.PreserveAspectCrop
            visible: index < 4
        }
    }
}
